part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}
class ChangePasswordVisibilityState extends LoginState {}
class LoginSuccessState extends LoginState {
  Login?model;
  LoginSuccessState(this.model);
}
class LoginLoadingState extends LoginState {}
class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
