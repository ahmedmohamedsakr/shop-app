import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shop_app/core/global/global_widget/global_widget.dart';
import 'package:shop_app/core/utils/app_constance.dart';
import 'package:shop_app/core/utils/navigation.dart';
import 'package:shop_app/core/services/cache_helper.dart';
import 'package:shop_app/core/utils/common_widget.dart';
import 'package:shop_app/presentation/controllers/register_cubit/register_cubit.dart';
import 'package:shop_app/presentation/controllers/register_cubit/register_state.dart';
import 'package:shop_app/presentation/screens/home_layout_screen.dart';
import 'package:shop_app/presentation/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
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
                            'Register',
                            style: TextStyle(
                              fontSize: 30.0,
                              letterSpacing: 5.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Text(
                            'Register now to browse our hot offers.',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          buildTextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid name.';
                              }
                              return null;
                            },
                            prefix: const Icon(IconlyBroken.profile),
                            hint: 'Name',
                            label: 'User Name',
                            type: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 18.0,
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
                            prefix: Icon(IconlyBroken.message),
                            hint: 'Email Address',
                            label: 'Email',
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          buildTextFormField(
                            controller: passwordController,
                            label: 'Password',
                            hint: 'Password',
                            suffix: IconButton(
                              icon: Icon(
                                //todo: 1
                                RegisterCubit.get(context).suffix,
                              ),
                              onPressed: () {
                                RegisterCubit.get(context)
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
                            obscure: RegisterCubit.get(context).isPassword,
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          buildTextFormField(
                            controller: phoneController,
                            label: 'Phone',
                            hint: 'Phone',
                            type: TextInputType.phone,
                            prefix: const Icon(IconlyBroken.call),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid phone number.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          //todo : 2
                          (state is RegisterLoadingState)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : MaterialButton(
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    //todo:3
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).register(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  color: Colors.blueGrey,
                                  height: 50.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Register',
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
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateAndRemove(context, LoginScreen());
                                },
                                child: const Text(
                                  'Login',
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
