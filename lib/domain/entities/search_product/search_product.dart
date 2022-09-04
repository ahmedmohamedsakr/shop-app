import 'package:shop_app/domain/entities/home/products.dart';

class SearchProduct{
  bool status;
  List<Products> data;

  SearchProduct({required this.status, required this.data});
}