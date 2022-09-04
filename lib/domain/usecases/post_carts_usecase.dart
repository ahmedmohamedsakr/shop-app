import 'package:shop_app/domain/entities/carts/post_carts.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class PostCartsUsecase {
  BaseShopRepository baseShopRepository;

  PostCartsUsecase({required this.baseShopRepository});

  Future<PostCarts> execute({required Map<String, dynamic> data}) async {
    return await baseShopRepository.postCarts(data: data);
  }
}
