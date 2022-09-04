import 'package:dartz/dartz.dart';
import 'package:shop_app/domain/entities/login.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class PostLoginUsecase {
  BaseShopRepository baseShopRepository;

  PostLoginUsecase({required this.baseShopRepository});

  Future<Either<String,Login>> execute({required Map<String, dynamic> data}) async {
    return await baseShopRepository.postLogin(data: data);
  }

}
