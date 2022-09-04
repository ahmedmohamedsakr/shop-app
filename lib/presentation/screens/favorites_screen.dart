import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/global/global_widget/global_widget.dart';
import 'package:shop_app/domain/entities/home/products.dart';
import 'package:shop_app/presentation/controllers/home_cubit/home_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return (state is GetFavoritesLoadingState ||
                state is PostFavoritesLoadingState )
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (cubit.getFavoritesModel!.data.isEmpty)?const Center(child: Text('Empty Favorites List',),):ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavItems(
                  cubit.getFavoritesModel!.data[index].favoritesDataProduct,
                  context,
                ),
                itemCount: cubit.getFavoritesModel?.data.length,
              );
      },
    );
  }

  Widget buildFavItems(Products model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Dismissible(
        key: Key('${model.id}'),
        onDismissed: (direction) {
          HomeCubit.get(context).changeFavorites(id: model.id!);
        },
        direction: DismissDirection.startToEnd,
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.delete,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Delete',
                ),
              ],
            ),
          ),
        ),
        child: buildContainer(model: model, context: context),
      ),
    );
  }

  Widget buildContainer({
    required Products model,
    required BuildContext context,
  }) {
    final double width = MediaQuery.of(context).size.width;
    // final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 220.0,
      child: Stack(
        children: [
          Positioned(
            top: 35,
            left: 20,
            child: Material(
              child: Container(
                height: 180.0,
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(0.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(-10.0, 10.0),
                      blurRadius: 20.0,
                      spreadRadius: 4.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 30.0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              shadowColor: Colors.grey.withOpacity(0.5),
              elevation: 10.0,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 200.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: buildCachedNetworkImage(imageUrl: model.image,fit: BoxFit.contain),
                  ),
                  if (model.discount != 0)
                    Positioned(
                      top: 5.0,
                      left: 5.0,
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
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(10.0),
                          )),
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
            ),
          ),
          Positioned(
            left: 168.0,
            top: 70.0,
            child: SizedBox(
              width: 180.0,
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            overflow: TextOverflow.ellipsis,
                            height: 1.4,
                          ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${model.price.round()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        if (model.discount != 0)
                          Text(
                            '\$${model.oldPrice.round()}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w900,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            HomeCubit.get(context).changeFavorites(id: model.id!);
                          },
                          //padding: EdgeInsets.zero,
                          icon: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.6),
                            child: Icon(
                              Icons.favorite,
                              size: 18.0,
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
          ),
        ],
      ),
    );
  }
}
