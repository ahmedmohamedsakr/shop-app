import 'package:shop_app/data/models/categories_model/categories_data_model.dart';
import 'package:shop_app/domain/entities/categories/categories.dart';

class CategoriesModel extends Categories {
  CategoriesModel({required super.status, required super.data});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        status: json['status'],
        data: CategoriesDataModel.fromJson(json['data']),
      );
}
