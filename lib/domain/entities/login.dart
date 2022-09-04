import 'package:shop_app/domain/entities/login_data.dart';

class Login {
  bool status;
  String message;
  LoginData ?data;

  Login({required this.status,required this.message, required this.data});
}


