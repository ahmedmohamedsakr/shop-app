import 'package:shop_app/domain/entities/profile/profile.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class GetProfileUsecase{
  BaseShopRepository baseShopRepository;

  GetProfileUsecase({required this.baseShopRepository});

  Future<Profile> execute()async{
    return await baseShopRepository.getProfile();
  }
}