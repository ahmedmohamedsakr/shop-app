import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shop_app/core/global/global_widget/global_widget.dart';
import 'package:shop_app/core/utils/app_constance.dart';
import 'package:shop_app/core/utils/navigation.dart';
import 'package:shop_app/core/services/cache_helper.dart';
import 'package:shop_app/core/services/service_locator.dart';
import 'package:shop_app/core/utils/common_widget.dart';
import 'package:shop_app/presentation/controllers/login_cubit/login_cubit.dart';
import 'package:shop_app/presentation/screens/home_layout_screen.dart';
import 'package:shop_app/presentation/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.model!.status) {
              buildShowToast(
                message: state.model!.message,
                state: ToastState.success,
              );
              CacheHelper.setData(
                key: 'token',
                value: state.model?.data?.token,
              ).then((value) {
                if (value) {
                  AppConstance.token = state.model?.data?.token;
                  navigateAndRemove(context, HomeLayoutScreen());
                }
              });
            } else {
              buildShowToast(
                message: state.model!.message,
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          return KeyboardDismisser(
            gestures: const [
              GestureType.onTap,
              GestureType.onPanUpdateDownDirection
            ],
            child: Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 30.0,
                              letterSpacing: 5.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Text(
                            'login now to browse our hot offers.',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          buildTextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !value.contains('@') ||
                                  !value.endsWith('com')) {
                                return 'please enter valid email.';
                              }
                              return null;
                            },
                            prefix: const Icon(IconlyBroken.message),
                            hint: 'Email Address',
                            label: 'Email',
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          buildTextFormField(
                            controller: passwordController,
                            label: 'Password',
                            hint: 'Password',
                            suffix: IconButton(
                              icon: Icon(
                                LoginCubit.get(context).suffix,
                              ),
                              onPressed: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                            prefix: const Icon(IconlyBroken.password),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid password.';
                              }
                              return null;
                            },
                            obscure: LoginCubit.get(context).isPassword,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          (state is LoginLoadingState)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).login(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    color: Colors.green,
                                    height: 50.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.0,
                                            letterSpacing: 2.5,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          IconlyBroken.login,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text(
                                  'Sign-Up',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
