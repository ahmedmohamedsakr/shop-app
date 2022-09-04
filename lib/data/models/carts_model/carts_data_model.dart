import 'dart:developer';

import 'package:shop_app/data/models/carts_model/carts_items_model.dart';
import 'package:shop_app/domain/entities/carts/carts_data.dart';
import 'package:shop_app/domain/entities/carts/carts_items.dart';

class CartsDataModel extends CartsData {
  CartsDataModel({
    required super.cartsItems,
    required super.subTotal,
    required super.total,
  });

  factory CartsDataModel.fromJson(Map<String, dynamic> json) => CartsDataModel(
        cartsItems: List<CartsItems>.from(
          json['cart_items'].map(
            (e) {
              return CartItemsModel.fromJson(e);
            },
          ),
        ),
        subTotal: json['sub_total'],
        total: json['total'],
      );
}
