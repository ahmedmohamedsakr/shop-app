import 'dart:developer';

import 'package:shop_app/data/models/carts_model/carts_data_model.dart';
import 'package:shop_app/domain/entities/carts/carts.dart';

class CartsModel extends Carts {
  CartsModel({
    required super.status,
    required super.data,
  });

  factory CartsModel.fromJson(Map<String, dynamic> json) => CartsModel(
        status: json['status'],
        data: CartsDataModel.fromJson(
          json['data'],
        ),
      );
}
