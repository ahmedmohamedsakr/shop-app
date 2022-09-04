import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/global/global_widget/global_widget.dart';
import 'package:shop_app/domain/entities/categories/categories_data_data.dart';

Widget buildCategoriesItems(CategoriesDataData? categoriesModel) {
  return Card(
    elevation: 30.0,
    shadowColor: Colors.grey.withOpacity(0.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.0),
      // side: BorderSide(width: 0.1,color: Colors.black.withOpacity(.9),)
    ),
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        buildCachedNetworkImage(
          imageUrl: categoriesModel!.image!,
          width: 110,
          height: 100,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: 110,
          child: Text(
            '${categoriesModel.name}',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
              overflow: TextOverflow.ellipsis,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        )
      ],
    ),
  );
}
