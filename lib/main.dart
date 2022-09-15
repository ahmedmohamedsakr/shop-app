import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_observer.dart';
import 'package:shop_app/core/global/themes/theme_data/app_theme_dark.dart';
import 'package:shop_app/core/global/themes/theme_data/app_theme_light.dart';
import 'package:shop_app/core/services/cache_helper.dart';
import 'package:shop_app/core/services/service_locator.dart';
import 'package:shop_app/core/utils/app_constance.dart';
import 'package:shop_app/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:shop_app/presentation/controllers/search_cubit/search_cubit.dart';
import 'package:shop_app/presentation/screens/home_layout_screen.dart';
import 'package:shop_app/presentation/screens/login_screen.dart';
import 'package:shop_app/presentation/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  ServiceLocator.init();
  await CacheHelper.init();
  final bool? onBoard = CacheHelper.getData(key: 'onBoard');
  AppConstance.token = CacheHelper.getData(key: 'token');
  Widget page;
  if (onBoard != null) {
    if (AppConstance.token != null) {
      page = HomeLayoutScreen();
    } else {
      page = LoginScreen();
    }
  } else {
    page = const OnboardingScreen();
  }
  runApp(MyApp(
    initialPage: page,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.initialPage,
  }) : super(key: key);
  final Widget initialPage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getProfile()
        ..getCarts(),
      child: MaterialApp(
        title: 'Shop App',
        debugShowCheckedModeBanner: false,
        theme: getThemeDataLight(),
        home: initialPage,
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   Widget initialPage;
//
//   Home({Key? key, required this.initialPage}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()
//         ..getHomeData()
//         ..getCategories()
//         ..getFavorites()
//         ..getProfile()
//         ..getCarts(),
//       child: initialPage,
//     );
//   }
// }
