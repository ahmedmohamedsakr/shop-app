import 'package:shop_app/domain/entities/login.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class ChangeRegisterPasswordVisibilityState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  Login? model;

  RegisterSuccessState(this.model);
}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}
