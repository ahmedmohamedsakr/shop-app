import 'package:shop_app/data/models/home_model/products_model.dart';
import 'package:shop_app/domain/entities/home/products.dart';
import 'package:shop_app/domain/entities/search_product/search_product.dart';

class SearchProductModel extends SearchProduct {
  SearchProductModel({required super.status, required super.data});

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      SearchProductModel(
        status: json['status'],
        data: List<Products>.from(json['data']['data'].map((e) {
          return ProductsModel.fromJson(e);
        })),
      );
}
