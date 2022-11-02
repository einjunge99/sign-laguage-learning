class LocalUser {
  String authProvider;
  String? displayName;
  String email;
  String uid;

  LocalUser({
    required this.authProvider,
    this.displayName,
    required this.email,
    required this.uid,
  });

  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      authProvider: map['authProvider'] as String,
      displayName: map['displayName'] as String?,
      email: map['email'] as String,
      uid: map['uid'] as String,
    );
  }
}
