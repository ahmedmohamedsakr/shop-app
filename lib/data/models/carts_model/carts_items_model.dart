import 'package:shop_app/data/models/home_model/products_model.dart';
import 'package:shop_app/domain/entities/carts/carts_items.dart';

class CartItemsModel extends CartsItems {
  CartItemsModel({
    required super.id,
    required super.quantity,
    required super.cartItemsProduct,
  });

  factory CartItemsModel.fromJson(Map<String, dynamic> json) => CartItemsModel(
        id: json['id'],
        quantity: json['quantity'],
        cartItemsProduct: ProductsModel.fromJson(
          json['product'],
        ), //CartsItemsProductModel.fromJson(json['product']),
      );
}
