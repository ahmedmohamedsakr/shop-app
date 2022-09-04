import 'package:shop_app/domain/entities/categories/categories.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class GetCategoriesUsecase {
  BaseShopRepository baseShopRepository;

  GetCategoriesUsecase({required this.baseShopRepository});

  Future<Categories> execute() async {
    return await baseShopRepository.getCategories();
  }
}
