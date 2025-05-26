class UserInfoModel {
  final String? uid;
  final String firstName;
  final String lastName;
  final String email;

  String get fullName => '$firstName $lastName';

  UserInfoModel({
    this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserInfoModel.empty() =>
      UserInfoModel(uid: '', firstName: '', lastName: '', email: '');

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    uid: json['uid'], // 👈 changed from 'id' to 'uid'
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    email: json['email'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'uid': uid, // 👈 changed from 'id' to 'uid'
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
  };
}
