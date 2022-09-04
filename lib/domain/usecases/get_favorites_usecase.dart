import 'package:shop_app/domain/entities/favorites/get_favorites.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class GetFavoritesUsecase{
  BaseShopRepository baseShopRepository;

  GetFavoritesUsecase({required this.baseShopRepository});

  Future<GetFavorites> execute()async{
    return await baseShopRepository.getFavorites();
  }
}