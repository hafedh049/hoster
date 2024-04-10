final class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String clientType;

  UserModel({required this.uid, required this.name, required this.email, required this.password, required this.clientType});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(uid: json['uid'], name: json['name'], email: json['email'], password: json['password'], clientType: json['type']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'uid': uid, 'name': name, 'email': email, 'password': password, 'type': clientType};
}
