import 'package:shop_app/domain/entities/carts/carts_data.dart';

class Carts {
  bool status;
  // String message; always null.
  CartsData data;

  Carts({
    required this.status,
    required this.data,
  });
}
