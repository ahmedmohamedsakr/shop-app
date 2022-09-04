import 'package:shop_app/domain/entities/favorites/post_favorites.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class PostFavoritesUsecase {
  BaseShopRepository baseShopRepository;

  PostFavoritesUsecase({required this.baseShopRepository});

  Future<PostFavorites> execute({required Map<String, int> data}) async {
    return await baseShopRepository.postFavorites(data: data);
  }
}
