import 'dart:developer';

import 'package:shop_app/domain/entities/home/products.dart';

class ProductsModel extends Products {
  ProductsModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.image,
    required super.name,
    required super.description,
    super.images,
    super.inFavorites,
    super.inCart,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        image: json['image'],
        name: json['name'],
        inFavorites: json['in_favorites'],
        inCart: json['in_cart'],
        description: json['description'],
        images: List<String>.from(
          json['images'].map(
            (e) {
              return e;
            },
          ),
        ),
      );

  factory ProductsModel.fromFavJson(Map<String, dynamic> json) => ProductsModel(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        image: json['image'],
        name: json['name'],
        description: json['description'],
      );
}
