class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: _asInt(json['id']),
    username: _asString(json['username']),
    email: _asString(json['email']),
    firstName: _asString(json['firstName']),
    lastName: _asString(json['lastName']),
    gender: _asString(json['gender']),
    image: _asString(json['image']),
    accessToken: _asString(json['accessToken']),
    refreshToken: _asString(json['refreshToken']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'gender': gender,
    'image': image,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };

  static int _asInt(Object? value) => value is num ? value.toInt() : 0;

  static String _asString(Object? value) => value is String ? value : '';
}
