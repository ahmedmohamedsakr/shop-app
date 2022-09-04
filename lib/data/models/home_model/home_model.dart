import 'package:shop_app/data/models/home_model/home_data_model.dart';
import 'package:shop_app/domain/entities/home/home.dart';

class HomeModel extends Home {
  HomeModel({required super.status, required super.data});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json['status'],
        data: HomeDataModel.fromJson(json['data']),
      );
}
