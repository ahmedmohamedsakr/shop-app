import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/global/global_widget/global_widget.dart';
import 'package:shop_app/domain/entities/home/home.dart';

CarouselSlider buildBannerCarouselSlider(List<dynamic>? images) {
  return CarouselSlider(
    options: CarouselOptions(
      scrollDirection: Axis.horizontal,
      aspectRatio: 1.9,
      initialPage: 0,
      enableInfiniteScroll: false,
      scrollPhysics: const BouncingScrollPhysics(),
      viewportFraction: 0.90,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
      autoPlayAnimationDuration: const Duration(seconds: 1),
    ),
    items: images!.map((e) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9.0),
          child: buildCachedNetworkImage(
            imageUrl: e,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
      );
    }).toList(),
  );
}
