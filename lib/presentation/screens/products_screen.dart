import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/utils/common_widget.dart';
import 'package:shop_app/domain/entities/categories/categories.dart';
import 'package:shop_app/domain/entities/categories/categories_data_data.dart';
import 'package:shop_app/domain/entities/home/home.dart';
import 'package:shop_app/domain/entities/home/products.dart';
import 'package:shop_app/domain/entities/profile/profile.dart';
import 'package:shop_app/presentation/components/home_banner_component.dart';
import 'package:shop_app/presentation/components/home_categories_component.dart';
import 'package:shop_app/presentation/components/home_new_products_component.dart';
import 'package:shop_app/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:shop_app/presentation/screens/search_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is PostFavoritesSuccessState) {
          if (!state.model.status) {
            buildShowToast(
                message: state.model.message, state: ToastState.error);
          }
        }
      },
      builder: (context, state) {
        // log('product: ${HomeCubit.get(context).hashCode}');
        var cubit = HomeCubit.get(context);
        return (cubit.homeData != null && cubit.categories != null)
            ? buildHomeScrollView(
                homeModel: cubit.homeData,
                categoriesModel: cubit.categories,
                context: context,
                profileModel: cubit.profileModel,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget buildHomeScrollView({
    Home? homeModel,
    Categories? categoriesModel,
    Profile? profileModel,
    required BuildContext context,
  }) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///if you want search in home screen
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTypeAheadField(context),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Hello ${profileModel?.data.name.split(' ').first} 😉',
              //         style: const TextStyle(
              //           fontSize: 22.0,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: 'Arial'
              //         ),
              //       ),
              //       const Text(
              //         'Lets gets somethings?',
              //         style: TextStyle(
              //           fontSize: 16.0,
              //           height: 1.5,
              //           color: Colors.black26,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 15.0,
              ),
              buildBannerCarouselSlider(
                  homeModel?.data?.banners?.map((e) => e.image).toList()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 22.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    SizedBox(
                      height: 100.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCategoriesItems(
                            categoriesModel!.data!.data![index]),
                        itemCount: categoriesModel!.data!.data!.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 5.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'New Products',
                      style: TextStyle(
                        fontSize: 22.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        newProductsComponent(homeModel),
      ],
    );
  }
}

///another implementation for gridview.
// Widget buildProducts(
//     Home? homeModel, Categories? categoriesModel, BuildContext context) {
//   return SingleChildScrollView(
//     physics: const BouncingScrollPhysics(),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildBannerCarouselSlider(homeModel),
//         const SizedBox(
//           height: 20.0,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Categories',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   letterSpacing: 1.5,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               SizedBox(
//                 height: 100.0,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   physics: const BouncingScrollPhysics(),
//                   itemBuilder: (context, index) => buildCategoriesItems(
//                       categoriesModel!.data!.data![index]),
//                   itemCount: categoriesModel!.data!.data!.length,
//                   separatorBuilder: (context, index) => const SizedBox(
//                     width: 5.0,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15.0,
//               ),
//               const Text(
//                 'New Products',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   letterSpacing: 1.5,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 20.0,
//         ),
//         Container(
//           color: Colors.grey[300],
//           child: GridView.count(
//             crossAxisCount: 2,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             childAspectRatio: 1 / 1.56,
//             mainAxisSpacing: 2.0,
//             crossAxisSpacing: 2.0,
//             children: List.generate(
//               homeModel!.data!.products!.length,
//               (index) => buildGridProductItems(
//                   homeModel.data!.products![index], context),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
//   return buildCustomScrollView(homeModel, context, categoriesModel);
// }
