import 'package:flutter/material.dart';

class Gender {
  final int id;
  final String title;
  final Color baseColor;
  final String illustrationPath;

  const Gender({this.id, this.title, this.illustrationPath, this.baseColor});
}

final String _baseImagesPath = 'assets/images';

final List<Gender> genderList = [
  Gender(
    id: 0,
    title: 'Female',
    illustrationPath: '$_baseImagesPath/female.png',
    baseColor: Colors.pink,
  ),
  Gender(
    id: 1,
    title: 'Male',
    illustrationPath: '$_baseImagesPath/male.png',
    baseColor: Color.fromRGBO(214, 217, 234, 1),
  ),
];
