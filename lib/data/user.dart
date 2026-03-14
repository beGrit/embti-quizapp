class User {
  final String id;
  final String? displayName;
  final String? name;
  final String? mail;
  final String? mobilePhone;
  final bool? status;
  final String? verificationToken;

  User({
    required this.id,
    required this.displayName,
    this.name,
    this.mail,
    this.mobilePhone,
    required this.status,
    this.verificationToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final attributes = data['attributes'] as Map<String, dynamic>;

    return User(
      id: data['id'] as String,
      displayName: attributes['display_name'] ?? 'Unknown User',
      name: attributes['name'],
      mail: attributes['mail'],
      mobilePhone: attributes['field_mobile_phone'],
      status: attributes['status'] ?? false,
      verificationToken: attributes['verification_token'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User(id: $id, displayName: $displayName, name: $name, mail: $mail, mobilePhone: $mobilePhone, status: $status)';
  }
}
