import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop_app/core/utils/navigation.dart';
import 'package:shop_app/core/services/cache_helper.dart';
import 'package:shop_app/domain/entities/home/home.dart';
import 'package:shop_app/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:shop_app/presentation/controllers/search_cubit/search_cubit.dart';
import 'package:shop_app/presentation/screens/carts_screen.dart';
import 'package:shop_app/presentation/screens/categories_screen.dart';
import 'package:shop_app/presentation/screens/favorites_screen.dart';
import 'package:shop_app/presentation/screens/products_screen.dart';
import 'package:shop_app/presentation/screens/login_screen.dart';
import 'package:shop_app/presentation/screens/search_screen.dart';
import 'package:shop_app/presentation/screens/settings_screen.dart';

class HomeLayoutScreen extends StatelessWidget {
  List<Widget> pages = [
    ProductsScreen(),
    CategoriesScreen(),
    CartsScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(9.0),
            child: GNav(
              gap: 10.0,
              color: Colors.blueGrey,
              activeColor: Colors.white,
              tabBackgroundGradient: const LinearGradient(colors: [
                Colors.blue,
                Colors.blueAccent,
                Colors.lightBlue,
                Colors.lightBlueAccent,
              ]),
              onTabChange: (value) {
                cubit.changeCurrentIndex(value);
              },
              padding: const EdgeInsets.all(12.0),
              tabs: const [
                GButton(
                  icon: IconlyBold.home,
                  text: 'Home',
                ),
                GButton(
                  icon: IconlyBold.category,
                  text: 'Categories',
                ),
                GButton(
                  icon: IconlyBold.bag,
                  text: 'Carts',
                ),
                GButton(
                  icon: IconlyBold.heart,
                  text: 'Favorites',
                ),
                GButton(
                  icon: IconlyBold.setting,
                  text: 'Settings',
                ),
              ],
            ),
          ),
          body: pages[cubit.currentIndex],
        );
      },
    );
  }
}
