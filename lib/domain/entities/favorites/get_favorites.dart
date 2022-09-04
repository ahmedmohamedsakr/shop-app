import 'package:shop_app/domain/entities/favorites/favorites_data.dart';

class GetFavorites{
  bool status;
  List<FavoritesData> data;

  GetFavorites({required this.status,required this.data});
}