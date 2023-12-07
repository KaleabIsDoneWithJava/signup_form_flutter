class UserData {
  final String username;
  final String email;
  final String password;

  UserData(this.username, this.email, this.password);

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      json['username'] as String,
      json['email'] as String,
      json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
