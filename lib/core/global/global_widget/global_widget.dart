import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

TextFormField buildTextFormField({
  required TextEditingController controller,
  String? Function(String?)? validator,
  Function(String)? onChange,
  Function(String)? onSubmit,
  Widget? prefix,
  Widget? suffix,
  required String label,
  String? hint,
  TextInputType? type,
  bool? obscure,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    onFieldSubmitted: onSubmit,
    // onChanged: onChange,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      prefixIcon: prefix,
      hintText: hint,
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 20.0,
        ),
      ),
    ),
    keyboardType: type,
    obscureText: obscure ?? false,
  );
}

MaterialButton buildMaterialButton({
  double? height = 50,
  double? width = 60,
  Color? color,
  required Function()? onPressed,
  Widget? child,
}) {
  return MaterialButton(
    height: height,
    minWidth: width,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    onPressed: onPressed,
    child: child,
  );
}

CachedNetworkImage buildCachedNetworkImage({
  required String imageUrl,
  double? width,
  double? height,
  BoxFit? fit,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: width,
    height: height,
    fit: fit,
    placeholder: (context, url) => Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[800]!,
      child: Container(
        height: 200.0,
        width: 120.0,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    errorWidget: (context, url, error) => Image.asset('assets/images/empty-states.jpg'),
  );
}
