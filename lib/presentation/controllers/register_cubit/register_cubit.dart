import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/core/services/service_locator.dart';
import 'package:shop_app/domain/entities/login.dart';
import 'package:shop_app/domain/usecases/post_register_usecase.dart';
import 'package:shop_app/presentation/controllers/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  Login? model;
  IconData suffix = Icons.visibility_rounded;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(ChangeRegisterPasswordVisibilityState());
  }

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    sl<PostRegisterUsecase>().execute(
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      model = value;
      log(model!.data!.name);
      emit(RegisterSuccessState(model));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}
