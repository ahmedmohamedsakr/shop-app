import 'package:shop_app/data/models/categories_model/categories_data_data_model.dart';
import 'package:shop_app/domain/entities/categories/categories_data.dart';

class CategoriesDataModel extends CategoriesData {
  CategoriesDataModel({required super.currentPage, required super.data});

  factory CategoriesDataModel.fromJson(Map<String, dynamic> json) =>
      CategoriesDataModel(
        currentPage: json['current_page'],
        data: List<CategoriesDataDataModel>.from(
          json['data'].map(
            (e) => CategoriesDataDataModel.fromJson(e),
          ),
        ),
      );
}
