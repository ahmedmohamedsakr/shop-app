import 'package:shop_app/domain/entities/categories/categories_data_data.dart';

class CategoriesDataDataModel extends CategoriesDataData {
  CategoriesDataDataModel(
      {required super.id, required super.name, required super.image});

  factory CategoriesDataDataModel.fromJson(Map<String, dynamic> json) =>
      CategoriesDataDataModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
      );
}
