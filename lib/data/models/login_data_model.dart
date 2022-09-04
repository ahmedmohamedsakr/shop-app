import 'package:shop_app/domain/entities/login_data.dart';

class LoginDataModel extends LoginData {
  LoginDataModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.image,
    // required super.points,
    // required super.credit,
    required super.token,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        // points: json['points'],
        // credit: json['credit'],
        token: json['token'],
      );
}
