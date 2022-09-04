import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/core/services/service_locator.dart';
import 'package:shop_app/core/utils/app_constance.dart';
import 'package:shop_app/domain/entities/carts/carts.dart';
import 'package:shop_app/domain/entities/carts/post_carts.dart';
import 'package:shop_app/domain/entities/categories/categories.dart';
import 'package:shop_app/domain/entities/favorites/get_favorites.dart';
import 'package:shop_app/domain/entities/favorites/post_favorites.dart';
import 'package:shop_app/domain/entities/home/home.dart';
import 'package:shop_app/domain/entities/login.dart';
import 'package:shop_app/domain/entities/profile/profile.dart';
import 'package:shop_app/domain/usecases/get_carts_usecase.dart';
import 'package:shop_app/domain/usecases/get_categories_usecase.dart';
import 'package:shop_app/domain/usecases/get_favorites_usecase.dart';
import 'package:shop_app/domain/usecases/get_home_data_usecase.dart';
import 'package:shop_app/domain/usecases/get_profile_usecase.dart';
import 'package:shop_app/domain/usecases/post_carts_usecase.dart';
import 'package:shop_app/domain/usecases/post_favorites_usecase.dart';
import 'package:shop_app/domain/usecases/update_profile_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  Home? homeData;
  Map<int, bool> favorites = {};
  Map<int, bool> carts = {};

  void getHomeData() {
    emit(HomeDataLoadingState());
    sl<GetHomeDataUsecase>().execute().then(
      (value) {
        // log('home cubit:${value.data?.products![0].inFavorites}');
        homeData = value;
        for (var element in homeData!.data!.products!) {
          favorites.addAll({element.id!: element.inFavorites!});
        }
        for (var element in homeData!.data!.products!) {
          carts.addAll({element.id!: element.inCart!});
        }
        // log(carts.toString());
        // log(homeData!.data!.products![0].images.toString());
        emit(HomeDataSuccessState());
      },
    ).catchError((error) {
      emit(HomeDataErrorState(error.toString()));
    });
  }

  Categories? categories;

  void getCategories() {
    emit(CategoriesLoadingState());
    sl<GetCategoriesUsecase>().execute().then(
      (value) {
        categories = value;
        emit(CategoriesSuccessState());
      },
    ).catchError((error) {
      emit(CategoriesErrorState(error.toString()));
    });
  }

  PostFavorites? postFavoritesModel;

  void changeFavorites({required int id}) {
    favorites[id] = !favorites[id]!;
    emit(PostFavoritesLoadingState());
    sl<PostFavoritesUsecase>().execute(
      data: {'product_id': id},
    ).then(
      (value) async {
        postFavoritesModel = value;
        if (!value.status) {
          favorites[id] = !favorites[id]!;
        } else {
          getFavorites();
        }
        emit(PostFavoritesSuccessState(postFavoritesModel!));
      },
    ).catchError((error) {
      emit(PostFavoritesErrorState(error.toString()));
    });
  }

  GetFavorites? getFavoritesModel;

  void getFavorites() {
    emit(GetFavoritesLoadingState());
    sl<GetFavoritesUsecase>().execute().then(
      (value) {
        getFavoritesModel = value;
        // log('message: ${getFavoritesModel?.data[0].favoritesDataProduct.name}');
        emit(GetFavoritesSuccessState(getFavoritesModel!));
      },
    ).catchError((error) {
      print('$error');
      emit(GetFavoritesErrorState(error.toString()));
    });
  }

  Profile? profileModel;

  void getProfile() {
    emit(GetProfileLoadingState());
    sl<GetProfileUsecase>().execute().then(
      (value) {
        profileModel = value;
        emit(GetProfileSuccessState(profileModel!));
      },
    ).catchError((error) {
      print('$error');
      emit(GetProfileErrorState(error.toString()));
    });
  }

  void updateProfile({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(UpdateProfileLoadingState());
    sl<UpdateProfileUsecase>().execute(data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then(
      (value) {
        profileModel = value;
        emit(UpdateProfileSuccessState(profileModel!));
      },
    ).catchError((error) {
      log('$error');
      emit(UpdateProfileErrorState(error.toString()));
    });
  }

  PostCarts? postCartsModel;

  void changeCarts({required int id}) {
    carts[id] = !carts[id]!;
    emit(PostCartsLoadingState());
    sl<PostCartsUsecase>().execute(
      data: {'product_id': id},
    ).then(
      (value) async {
        postCartsModel = value;
        if (!value.status) {
          carts[id] = !carts[id]!;
        } else {
          getCarts();
        }
        emit(PostCartsSuccessState(postCartsModel!));
      },
    ).catchError((error) {
      emit(PostCartsErrorState(error.toString()));
    });
  }

  Carts? cartsModel;

  void getCarts() {
    emit(GetCartsLoadingState());
    sl<GetCartsUsecase>().execute().then((value) {
      cartsModel = value;
      // log('carts model data: ${cartsModel?.data.cartsItems[0].cartsItemsProduct.name}');
      emit(GetCartsSuccessState(cartsModel!));
    }).catchError((error) {
      log(error.toString());
      emit(GetCartsErrorState(error.toString()));
    });
  }
}
