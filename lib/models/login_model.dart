class Login {
  final bool status;
  final String? message;
  final UserData? data;

  Login({
    required this.status,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }

  factory Login.fromJson(dynamic map) {
    return Login(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      data: map['data'] == null ? null : UserData.fromJson(map['data']),
    );
  }

  // String toJson() => json.encode(toJson());

  // factory Login.fromJson(String source) => Login.fromJson(json.decode(source));
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final int credit;
  final String token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'points': points,
      'credit': credit,
      'token': token,
    };
  }

  factory UserData.fromJson(dynamic map) {
    return UserData(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      points: map['points']?.toInt() ?? 0,
      credit: map['credit']?.toInt() ?? 0,
      token: map['token'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserData.fromJson(String source) =>
  //     UserData.fromMap(json.decode(source));
}
