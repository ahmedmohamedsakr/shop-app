import 'package:shop_app/domain/entities/carts/carts.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class GetCartsUsecase {
  BaseShopRepository baseShopRepository;

  GetCartsUsecase({required this.baseShopRepository});

  Future<Carts> execute() async {
    return await baseShopRepository.getCarts();
  }
}
