import 'package:shop_app/domain/entities/login_data.dart';

class Profile{
  bool status;
  String ?message;
  LoginData data;

  Profile({required this.status,required this.data,required this.message});
}