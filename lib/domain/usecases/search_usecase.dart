import 'package:shop_app/domain/entities/search_product/search_product.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class SearchUsecase {
  BaseShopRepository baseShopRepository;

  SearchUsecase({required this.baseShopRepository});

  Future<SearchProduct> execute({required Map<String, String> data}) async {
    return await baseShopRepository.search(data: data);
  }
}
