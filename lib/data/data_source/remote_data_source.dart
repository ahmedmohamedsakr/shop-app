import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop_app/core/services/service_locator.dart';
import 'package:shop_app/core/utils/app_constance.dart';
import 'package:shop_app/data/models/carts_model/carts_model.dart';
import 'package:shop_app/data/models/carts_model/post_carts_model.dart';
import 'package:shop_app/data/models/categories_model/categories_model.dart';
import 'package:shop_app/data/models/favorites_model/get_favorites_model.dart';
import 'package:shop_app/data/models/favorites_model/post_favorites_model.dart';
import 'package:shop_app/data/models/home_model/home_model.dart';
import 'package:shop_app/data/models/login_model.dart';
import 'package:shop_app/data/models/profile_model/profile_model.dart';
import 'package:shop_app/data/models/search_product_model/search_product_model.dart';

abstract class BaseRemoteDataSource {
  Future<HomeModel> getHomeData();

  Future<LoginModel> postLogin({required Map<String, dynamic> data});

  Future<LoginModel> postRegister({required Map<String, dynamic> data});

  Future<CategoriesModel> getCategories();

  Future<PostFavoritesModel> postFavorites({required Map<String, int> data});

  Future<GetFavoritesModel> getFavorites();

  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile({required Map<String, dynamic> data});

  Future<SearchProductModel> search({required Map<String, String> data});

  Future<PostCartsModel> postCarts({required Map<String, dynamic> data});

  Future<CartsModel> getCarts();
}

class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<LoginModel> postLogin({required Map<String, dynamic> data}) async {
    final response = await sl<Dio>().post(AppConstance.login, data: data);
    if (response.statusCode == 200) {
      return LoginModel.fromJson(response.data);
    } else {
      //todo: check if status code not 200.
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<LoginModel> postRegister({required Map<String, dynamic> data}) async {
    final response = await sl<Dio>().post(AppConstance.register, data: data);
    if (response.statusCode == 200) {
      // log('response:${response.data}');
      return LoginModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<HomeModel> getHomeData() async {
    final response = await sl<Dio>().get(
      AppConstance.home,
    );
    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<CategoriesModel> getCategories() async {
    final response = await sl<Dio>().get(
      AppConstance.categories,
    );
    if (response.statusCode == 200) {
      return CategoriesModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<PostFavoritesModel> postFavorites(
      {required Map<String, int> data}) async {
    final response = await sl<Dio>().post(AppConstance.favorites, data: data);
    if (response.statusCode == 200) {
      return PostFavoritesModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<GetFavoritesModel> getFavorites() async {
    final response = await sl<Dio>().get(AppConstance.favorites);
    if (response.statusCode == 200) {
      // log('data source: ${response.data}');
      return GetFavoritesModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    final response = await sl<Dio>().get(AppConstance.profile);
    if (response.statusCode == 200) {
      // log('data source: ${response.data}');
      return ProfileModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<ProfileModel> updateProfile(
      {required Map<String, dynamic> data}) async {
    final response =
        await sl<Dio>().put(AppConstance.updateProfile, data: data);
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<SearchProductModel> search({required Map<String, String> data}) async {
    final response = await sl<Dio>().post(AppConstance.search, data: data);
    if (response.statusCode == 200) {
      // log('response: ${response.data}');
      return SearchProductModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<PostCartsModel> postCarts({required Map<String, dynamic> data}) async {
    final response = await sl<Dio>().post(AppConstance.carts, data: data);
    if (response.statusCode == 200) {
      // log('response: ${response.data}');
      return PostCartsModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<CartsModel> getCarts() async {
    final response = await sl<Dio>().get(AppConstance.carts);
    if (response.statusCode == 200) {
      // log('response: ${response.data}');
      return CartsModel.fromJson(response.data);
    } else {
      log('${response.data['message']}');
      throw Exception(response.data['message']);
    }
  }
}
