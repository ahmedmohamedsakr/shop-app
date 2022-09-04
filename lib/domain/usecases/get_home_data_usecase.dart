import 'package:shop_app/domain/entities/home/home.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';


class GetHomeDataUsecase {
  BaseShopRepository baseShopRepository;

  GetHomeDataUsecase({required this.baseShopRepository});

  Future<Home> execute() async {
    return await baseShopRepository.getHomeData();
  }

}
