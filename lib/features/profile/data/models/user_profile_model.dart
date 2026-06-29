import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/profile/domain/entities/user_profile.dart';

class UserProfileModel {
  final String uid;
  final String? name;
  final String? email;
  final String? preferences;
  final String? celNumber;
  final String? photoUrl;
  final String? usercode;
  final bool partnerCheck;
  final bool acceptTerms;
  final bool allowPush;
  final bool allowEmail;
  final bool firstLaunch;

  const UserProfileModel({
    required this.uid,
    this.name,
    this.email,
    this.preferences,
    this.celNumber,
    this.photoUrl,
    this.usercode,
    this.partnerCheck = false,
    this.acceptTerms = false,
    this.allowPush = false,
    this.allowEmail = false,
    this.firstLaunch = true,
  });

  factory UserProfileModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};
    return UserProfileModel(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      preferences: data['preferences'],
      celNumber: data['cel_number'],
      photoUrl: data['photo_url'],
      usercode: data['usercode'],
      partnerCheck: data['partner_check'] ?? false,
      acceptTerms: data['accept_terms'] ?? false,
      allowPush: data['allow_push'] ?? false,
      allowEmail: data['allow_emails'] ?? false,
      firstLaunch: data['first_launch'] ?? true,
    );
  }

  UserProfile toEntity() => UserProfile(
    uid: uid,
    name: name,
    email: email,
    preferences: preferences,
    celNumber: celNumber,
    photoUrl: photoUrl,
    usercode: usercode,
    partnerCheck: partnerCheck,
    acceptTerms: acceptTerms,
    allowPush: allowPush,
    allowEmail: allowEmail,
    firstLaunch: firstLaunch,
  );
}
