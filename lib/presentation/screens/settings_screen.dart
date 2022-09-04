import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/core/global/global_widget/global_widget.dart';
import 'package:shop_app/core/utils/app_constance.dart';
import 'package:shop_app/core/utils/common_widget.dart';
import 'package:shop_app/presentation/controllers/home_cubit/home_cubit.dart';

class SettingsScreen extends StatelessWidget {
  bool isDark = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          if (state.model.status) {
            buildShowToast(
              message: state.model.message!,
              state: ToastState.success,
            );
          } else {
            buildShowToast(
              message: state.model.message!,
              state: ToastState.error,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        nameController.text = cubit.profileModel!.data.name;
        emailController.text = cubit.profileModel!.data.email;
        phoneController.text = cubit.profileModel!.data.phone;
        if (cubit.profileModel != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4.0,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    buildTextFormField(
                        controller: nameController,
                        label: 'Name',
                        prefix: const Icon(
                          IconlyBroken.profile,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter valid name.';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15.0,
                    ),
                    buildTextFormField(
                        controller: emailController,
                        label: 'Email',
                        prefix: const Icon(
                          IconlyBroken.message,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter valid email.';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15.0,
                    ),
                    buildTextFormField(
                      controller: phoneController,
                      label: 'Phone',
                      prefix: const Icon(
                        IconlyBroken.call,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter valid phone number.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    (state is UpdateProfileLoadingState)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : buildMaterialButton(
                            height: 50.0,
                            width: double.infinity,
                            color: Colors.blueGrey,
                            onPressed: () {
                              cubit.updateProfile(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'UPDATE',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 3.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(
                                  IconlyBroken.edit,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    buildMaterialButton(
                      height: 50.0,
                      width: double.infinity,
                      color: Colors.red,
                      onPressed: () {
                        AppConstance.signOut(context: context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'LOGOUT',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3.0,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(
                            IconlyBroken.logout,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Preferences',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4.0,
                      ),
                    ),
                    buildListTile(
                      title: 'Dark Mode',
                      leading: const CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 19.5,
                        child: Icon(
                          Icons.dark_mode,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Switch(
                        value: isDark,
                        onChanged: (value) {
                          isDark = value;
                        },
                        activeColor: Colors.white,
                      ),
                    ),
                    buildListTile(
                      title: 'Language',
                      leading: const CircleAvatar(
                          radius: 19.5,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.language,
                            color: Colors.white,
                          )),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'English',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(
                            color: Colors.white,
                            Icons.arrow_forward_ios,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildListTile(
      {required String title,
      required Widget leading,
      required Widget trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          leading: leading,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18.0,
              letterSpacing: 2.0,
              color: Colors.white,
            ),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
