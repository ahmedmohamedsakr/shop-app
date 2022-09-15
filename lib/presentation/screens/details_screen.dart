import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:shop_app/core/global/global_widget/global_widget.dart';
import 'package:shop_app/core/utils/navigation.dart';
import 'package:shop_app/domain/entities/home/products.dart';
import 'package:shop_app/presentation/components/home_banner_component.dart';
import 'package:shop_app/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:shop_app/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsScreen extends StatelessWidget {
  Products model;
  PageController pageController = PageController();
  //HomeCubit cubit;
  DetailsScreen({
    Key? key,
    required this.model,
    // required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('details: ${model.id}');
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.only(
                  right: 15.0, left: 15.0, bottom: 10.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                PageView.builder(
                                  controller: pageController,
                                  itemBuilder: (context, index) =>
                                      buildDetailImages(
                                          imageUrl: model.images![index]!),
                                  itemCount: model.images?.length,
                                  physics: const BouncingScrollPhysics(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: SmoothPageIndicator(
                              controller: pageController,
                              count: model.images!.length,
                              effect: const ExpandingDotsEffect(
                                dotHeight: 10.0,
                                dotWidth: 10.0,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.blueGrey,
                                spacing: 5,
                                expansionFactor: 2.6,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  model.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        height: 1.4,
                                        fontSize: 18.0,
                                      ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  ///todo
                                  HomeCubit.get(context)
                                      .changeFavorites(id: model.id!);
                                  // cubit.changeFavorites(id: model.id!);
                                },
                                padding: EdgeInsets.zero,
                                icon: CircleAvatar(
                                  maxRadius: 18.0,
                                  backgroundColor:
                                      Colors.grey.withOpacity(0.6),
                                  child: Icon(
                                    IconlyBold.heart,
                                    size: 21.0,
                                    ///todo
                                    color: (HomeCubit.get(context)
                                            .favorites[model.id]!)
                                    // (cubit.favorites[model.id]!)
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                '\$${model.price.round()!}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              if (model.price < model.oldPrice)
                                Text(
                                  '\$${model.oldPrice.round()!}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          fontWeight: FontWeight.w900,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.black26),
                                ),
                              const Spacer(),
                              Text(
                                'Available in Stock',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Arial',
                                      color: Colors.blueGrey,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'About',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                  fontFamily: 'Arial',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            '${model.description}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontFamily: 'Arial',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  buildAnimatedButton(context, state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAnimatedButton(BuildContext context, HomeState state) {
    double width = (state is PostCartsLoadingState)
        ? 70.0
        : MediaQuery.of(context).size.width;
    ///todo
    Color color =
        (HomeCubit.get(context).carts[model.id]!)/* cubit.carts[model.id]!*/ ? Colors.red : Colors.green;
    String text = (HomeCubit.get(context).carts[model.id]!)
       /*cubit.carts[model.id]!*/ ? 'Remove from cart'
        : 'Add to cart';
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 11.0,
        // vertical: 5.0,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 60.0,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: color,
        ),
        child: (state is PostCartsLoadingState)
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : buildMaterialButton(context, text),
      ),
    );
  }

  Widget buildMaterialButton(BuildContext context, String text) {
    return MaterialButton(
      onPressed: () {
        ///todo
        HomeCubit.get(context).changeCarts(id: model.id!);
        // cubit.changeCarts(id: model.id!);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Icon(
            IconlyBold.bag,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget buildDetailImages({required String imageUrl}) {
    return buildCachedNetworkImage(
      imageUrl: imageUrl,
    );
  }
}
