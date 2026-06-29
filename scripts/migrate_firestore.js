#!/usr/bin/env node
/*
 * One-off migration: flattens the legacy Honey IOU Firestore schema
 * (users/{uid}/{uid}/{uid}, partner_requests/{uid}/{uid}/{senderUid},
 * partners_accepted/{uid}/{uid}/{partnerUid}) into the new flat schema
 * (users/{uid}, partner_requests/{receiverUid}_{senderUid},
 * partners_accepted/{uid}/partners/{partnerUid}).
 *
 * Requires Application Default Credentials with access to the
 * honeyiou-f3413 project (run `gcloud auth application-default login`
 * first, or set GOOGLE_APPLICATION_CREDENTIALS to a service account key).
 *
 * Usage:
 *   npm install
 *   node migrate_firestore.js --dry-run   # preview only, no writes
 *   node migrate_firestore.js             # actually migrate
 */

const admin = require('firebase-admin');

const PROJECT_ID = 'honeyiou-f3413';
const DRY_RUN = process.argv.includes('--dry-run');

admin.initializeApp({ projectId: PROJECT_ID });
const db = admin.firestore();
const auth = admin.auth();

async function listAllUids() {
  const uids = [];
  let pageToken;
  do {
    const page = await auth.listUsers(1000, pageToken);
    page.users.forEach((u) => uids.push(u.uid));
    pageToken = page.pageToken;
  } while (pageToken);
  return uids;
}

async function migrateUserDoc(uid) {
  const nestedRef = db
    .collection('users')
    .doc(uid)
    .collection(uid)
    .doc(uid);
  const nestedSnap = await nestedRef.get();
  if (!nestedSnap.exists) return { migrated: false };

  const flatRef = db.collection('users').doc(uid);
  const flatSnap = await flatRef.get();
  if (flatSnap.exists) return { migrated: false, alreadyFlat: true };

  const data = nestedSnap.data();
  console.log(`  users/${uid}: ${DRY_RUN ? 'would copy' : 'copying'} ${Object.keys(data).join(', ')}`);
  if (!DRY_RUN) {
    await flatRef.set(data, { merge: true });
  }
  return { migrated: true };
}

async function migratePartnerRequests(uid) {
  const nestedCollection = db
    .collection('partner_requests')
    .doc(uid)
    .collection(uid);
  const snaps = await nestedCollection.get();
  let count = 0;
  for (const doc of snaps.docs) {
    const data = doc.data();
    const senderUid = data.sender_uid || doc.id;
    const receiverUid = data.receiver_uid || uid;
    const flatId = `${receiverUid}_${senderUid}`;
    console.log(`  partner_requests/${flatId}: ${DRY_RUN ? 'would copy' : 'copying'}`);
    if (!DRY_RUN) {
      await db.collection('partner_requests').doc(flatId).set(data, { merge: true });
    }
    count++;
  }
  return count;
}

async function migratePartnersAccepted(uid) {
  const nestedCollection = db
    .collection('partners_accepted')
    .doc(uid)
    .collection(uid);
  const snaps = await nestedCollection.get();
  let count = 0;
  for (const doc of snaps.docs) {
    const data = doc.data();
    const partnerUid = data.partner_uid || doc.id;
    console.log(`  partners_accepted/${uid}/partners/${partnerUid}: ${DRY_RUN ? 'would copy' : 'copying'}`);
    if (!DRY_RUN) {
      await db
        .collection('partners_accepted')
        .doc(uid)
        .collection('partners')
        .doc(partnerUid)
        .set(data, { merge: true });
    }
    count++;
  }
  return count;
}

async function main() {
  console.log(`Migrating Firestore data for project ${PROJECT_ID}${DRY_RUN ? ' (dry run)' : ''}`);
  const uids = await listAllUids();
  console.log(`Found ${uids.length} Auth users.`);

  let usersMigrated = 0;
  let requestsMigrated = 0;
  let acceptedMigrated = 0;

  for (const uid of uids) {
    const userResult = await migrateUserDoc(uid);
    if (userResult.migrated) usersMigrated++;
    requestsMigrated += await migratePartnerRequests(uid);
    acceptedMigrated += await migratePartnersAccepted(uid);
  }

  console.log('---');
  console.log(`users migrated: ${usersMigrated}`);
  console.log(`partner_requests migrated: ${requestsMigrated}`);
  console.log(`partners_accepted migrated: ${acceptedMigrated}`);
  if (DRY_RUN) console.log('Dry run only -- no writes were made. Re-run without --dry-run to apply.');
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
