import 'package:dartz/dartz.dart';
import 'package:shop_app/domain/entities/carts/carts.dart';
import 'package:shop_app/domain/entities/carts/post_carts.dart';
import 'package:shop_app/domain/entities/categories/categories.dart';
import 'package:shop_app/domain/entities/favorites/get_favorites.dart';
import 'package:shop_app/domain/entities/favorites/post_favorites.dart';
import 'package:shop_app/domain/entities/home/home.dart';
import 'package:shop_app/domain/entities/login.dart';
import 'package:shop_app/domain/entities/profile/profile.dart';
import 'package:shop_app/domain/entities/search_product/search_product.dart';

abstract class BaseShopRepository {
  Future<Either<String, Login>> postLogin({required Map<String, dynamic> data});

  Future<Login> postRegister({required Map<String, dynamic> data});

  Future<Home> getHomeData();

  Future<Categories> getCategories();

  Future<GetFavorites> getFavorites();

  Future<PostFavorites> postFavorites({required Map<String, int> data});

  Future<Profile> getProfile();

  Future<Profile> updateProfile({required Map<String, dynamic> data});

  Future<SearchProduct> search({required Map<String, String> data});

  Future<PostCarts> postCarts({required Map<String, dynamic> data});
  Future<Carts> getCarts();
}
