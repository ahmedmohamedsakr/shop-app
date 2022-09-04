import 'package:shop_app/data/models/login_data_model.dart';
import 'package:shop_app/domain/entities/profile/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({required super.status, required super.data,required super.message});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json['status'],
        message: json['message'],
        data: LoginDataModel.fromJson(
          json['data'],
        ),
      );
}
