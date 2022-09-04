import 'package:shop_app/domain/entities/carts/post_carts.dart';

class PostCartsModel extends PostCarts {
  PostCartsModel({required super.status, required super.message});

  factory PostCartsModel.fromJson(Map<String, dynamic> json) => PostCartsModel(
        status: json['status'],
        message: json['message'],
      );
}
