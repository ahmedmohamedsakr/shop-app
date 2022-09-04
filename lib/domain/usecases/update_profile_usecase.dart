import 'package:shop_app/domain/entities/profile/profile.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class UpdateProfileUsecase {
  BaseShopRepository baseShopRepository;

  UpdateProfileUsecase({required this.baseShopRepository});

  Future<Profile> execute({required Map<String, dynamic> data}) async {
    return await baseShopRepository.updateProfile(data: data);
  }
}
