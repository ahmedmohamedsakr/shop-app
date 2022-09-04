import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shop_app/data/data_source/remote_data_source.dart';
import 'package:shop_app/domain/entities/carts/carts.dart';
import 'package:shop_app/domain/entities/carts/post_carts.dart';
import 'package:shop_app/domain/entities/categories/categories.dart';
import 'package:shop_app/domain/entities/favorites/get_favorites.dart';
import 'package:shop_app/domain/entities/favorites/post_favorites.dart';
import 'package:shop_app/domain/entities/home/home.dart';
import 'package:shop_app/domain/entities/login.dart';
import 'package:shop_app/domain/entities/profile/profile.dart';
import 'package:shop_app/domain/entities/search_product/search_product.dart';
import 'package:shop_app/domain/repository/baseShopRepository.dart';

class ShopRepository extends BaseShopRepository {
  BaseRemoteDataSource baseRemoteDataSource;

  ShopRepository({required this.baseRemoteDataSource});

  @override
  Future<Either<String, Login>> postLogin(
      {required Map<String, dynamic> data}) async {
    final result = await baseRemoteDataSource.postLogin(data: data);

    try {
      return right(result);
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Home> getHomeData() async {
    return await baseRemoteDataSource.getHomeData();
  }

  @override
  Future<Categories> getCategories() async {
    return await baseRemoteDataSource.getCategories();
  }

  @override
  Future<PostFavorites> postFavorites({required Map<String, int> data}) async {
    return await baseRemoteDataSource.postFavorites(data: data);
  }

  @override
  Future<GetFavorites> getFavorites() async {
    return await baseRemoteDataSource.getFavorites();
  }

  @override
  Future<Profile> getProfile() async {
    return await baseRemoteDataSource.getProfile();
  }

  @override
  Future<Login> postRegister({required Map<String, dynamic> data}) async {
    return await baseRemoteDataSource.postRegister(data: data);
  }

  @override
  Future<Profile> updateProfile({required Map<String, dynamic> data}) async {
    return await baseRemoteDataSource.updateProfile(data: data);
  }

  @override
  Future<SearchProduct> search({required Map<String, String> data}) async {
    return await baseRemoteDataSource.search(data: data);
  }

  @override
  Future<PostCarts> postCarts({required Map<String, dynamic> data}) async{
   return await baseRemoteDataSource.postCarts(data: data);
  }

  @override
  Future<Carts> getCarts() async{
    return await baseRemoteDataSource.getCarts();
  }
}
