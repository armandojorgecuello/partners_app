class UserProfile {
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

  const UserProfile({
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

  /// Moved out of lib/main.dart's `AuthGate` widget, where this check used
  /// to live inline against a raw Firestore document.
  bool get isComplete => firstLaunch != true && name != null && name!.isNotEmpty;
}
