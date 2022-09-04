import 'dart:developer';

import 'package:shop_app/data/models/home_model/products_model.dart';
import 'package:shop_app/domain/entities/favorites/favorites_data.dart';

class FavoritesDataModel extends FavoritesData {
  FavoritesDataModel({
    required super.id,
    required super.favoritesDataProduct,
  });

  factory FavoritesDataModel.fromJson(Map<String, dynamic> json) =>
      FavoritesDataModel(
        id: json['id'],
        favoritesDataProduct: ProductsModel.fromFavJson(
          json['product'],
        ),
      );
}
