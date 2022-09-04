import 'package:shop_app/domain/entities/favorites/post_favorites.dart';

class PostFavoritesModel extends PostFavorites {
  PostFavoritesModel({required super.status, required super.message});

  factory PostFavoritesModel.fromJson(Map<String, dynamic> json) => PostFavoritesModel(
        status: json['status'],
        message: json['message'],
      );
}
