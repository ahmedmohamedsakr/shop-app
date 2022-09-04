import 'package:shop_app/domain/entities/categories/categories_data_data.dart';

class CategoriesData {
  int? currentPage;
  List<CategoriesDataData>? data;

  CategoriesData({required this.currentPage, required this.data});
}
