import 'package:flutter/material.dart';

class Onboarding {
  final String image;
  final String title;
  final String body;
  final Color backgroundColor;
  final String animation;

  Onboarding({
    required this.image,
    required this.title,
    required this.body,
    required this.backgroundColor,
    required this.animation,
  });

  List<Object> get props => [image, title, body,backgroundColor,animation];
}
