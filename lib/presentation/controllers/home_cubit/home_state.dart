part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class ChangeNavBarState extends HomeState {}

///Home States
class HomeDataSuccessState extends HomeState {}
class HomeDataErrorState extends HomeState {
  final String error;

  HomeDataErrorState(this.error);
}
class HomeDataLoadingState extends HomeState {}

///Categories State
class CategoriesSuccessState extends HomeState {}
class CategoriesErrorState extends HomeState {
  final String error;

  CategoriesErrorState(this.error);
}
class CategoriesLoadingState extends HomeState {}

///Post Favorites States
class PostFavoritesSuccessState extends HomeState {
  final PostFavorites model;
  PostFavoritesSuccessState(this.model);
}
class PostFavoritesErrorState extends HomeState {
  final String error;

  PostFavoritesErrorState(this.error);
}
class PostFavoritesLoadingState extends HomeState {}

///Get Favorites States
class GetFavoritesSuccessState extends HomeState {
  final GetFavorites model;
  GetFavoritesSuccessState(this.model);
}
class GetFavoritesErrorState extends HomeState {
  final String error;

  GetFavoritesErrorState(this.error);
}
class GetFavoritesLoadingState extends HomeState {}

///Get Profile States
class GetProfileSuccessState extends HomeState {
  final Profile model;
  GetProfileSuccessState(this.model);
}
class GetProfileErrorState extends HomeState {
  final String error;

  GetProfileErrorState(this.error);
}
class GetProfileLoadingState extends HomeState {}

///Get Profile States
class UpdateProfileSuccessState extends HomeState {
  final Profile model;
  UpdateProfileSuccessState(this.model);
}
class UpdateProfileErrorState extends HomeState {
  final String error;

  UpdateProfileErrorState(this.error);
}
class UpdateProfileLoadingState extends HomeState {}

///Post Carts States
class PostCartsSuccessState extends HomeState {
  final PostCarts model;
  PostCartsSuccessState(this.model);
}
class PostCartsErrorState extends HomeState {
  final String error;

  PostCartsErrorState(this.error);
}
class PostCartsLoadingState extends HomeState {}

///get carts States
class GetCartsSuccessState extends HomeState {
  final Carts model;
  GetCartsSuccessState(this.model);
}
class GetCartsErrorState extends HomeState {
  final String error;

  GetCartsErrorState(this.error);
}
class GetCartsLoadingState extends HomeState {}
