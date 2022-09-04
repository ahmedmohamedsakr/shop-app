import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/core/global/global_widget/global_widget.dart';
import 'package:shop_app/core/utils/navigation.dart';
import 'package:shop_app/domain/entities/home/home.dart';
import 'package:shop_app/domain/entities/home/products.dart';
import 'package:shop_app/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:shop_app/presentation/screens/details_screen.dart';

SliverGrid newProductsComponent(Home? homeModel) {
  return SliverGrid(
    delegate: SliverChildBuilderDelegate(
      childCount: homeModel?.data?.products?.length,
      (context, index) => FadeInUp(
        from: 20,
        duration: const Duration(microseconds: 500),
        child: buildGridProductItems(
          homeModel!.data!.products![index],
          context,
        ),
      ),
    ),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 3.0,
      childAspectRatio: 1 / 1.84,
      crossAxisCount: 2,
    ),
  );
}

Widget buildGridProductItems(Products model, BuildContext context) {
  return GestureDetector(
    onTap: (){
      navigateTo(context, DetailsScreen(model: model,));
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 7.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: buildCachedNetworkImage(
                    imageUrl: model.image,
                    height: 200.0,
                    width: double.infinity,
                  ),
                ),
                if (model.discount != 0)
                  Positioned(
                    top: 3.0,
                    left: 1.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.blueGrey.withOpacity(0.5),
                      ),
                      child: Text(
                        '${(100 * (model.oldPrice - model.price) / model.oldPrice).round()}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        height: 1.4,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${model.price.round()}',
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.w900,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        if (model.discount != 0)
                          Text(
                            '\$${model.oldPrice.round()}',
                            style: const TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w900,
                              fontSize: 11.0,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            HomeCubit.get(context).changeFavorites(id: model.id!);
                          },
                          padding: EdgeInsets.zero,
                          icon: CircleAvatar(
                            maxRadius: 18.0,
                            backgroundColor: Colors.grey.withOpacity(0.6),
                            child: Icon(
                              IconlyBold.heart,
                              size: 21.0,
                              color: (HomeCubit.get(context).favorites[model.id]!)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
