import 'package:shop_app/domain/entities/login.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class PostRegisterUsecase {
  BaseShopRepository baseShopRepository;

  PostRegisterUsecase({required this.baseShopRepository});

  Future<Login> execute({required Map<String, dynamic> data}) async {
    return await baseShopRepository.postRegister(data: data);
  }
}
