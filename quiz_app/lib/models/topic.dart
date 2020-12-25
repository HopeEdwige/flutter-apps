import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Topic {
  final int id;
  final String name;
  final dynamic icon;
  final dynamic iconColor;

  Topic({this.id, this.name, this.icon, this.iconColor});
}

List<dynamic> lastColors = [];

final List<Topic> topics = [
  Topic(
    id: 9,
    name: "General Knowledge",
    iconColor: Colors.green,
    icon: FontAwesomeIcons.globeAsia,
  ),
  Topic(
    id: 10,
    name: "Books",
    iconColor: Colors.blue,
    icon: FontAwesomeIcons.bookOpen,
  ),
  Topic(
    id: 11,
    name: "Film",
    iconColor: Colors.purple,
    icon: FontAwesomeIcons.video,
  ),
  Topic(
    id: 12,
    name: "Music",
    iconColor: Colors.deepOrange,
    icon: FontAwesomeIcons.music,
  ),
  Topic(
    id: 13,
    name: "Musicals & Theatres",
    iconColor: Colors.red,
    icon: FontAwesomeIcons.theaterMasks,
  ),
  Topic(
    id: 14,
    name: "Television",
    iconColor: Colors.lightGreenAccent,
    icon: FontAwesomeIcons.tv,
  ),
  Topic(
    id: 15,
    name: "Video Games",
    iconColor: Colors.amber,
    icon: FontAwesomeIcons.gamepad,
  ),
  Topic(
    id: 16,
    name: "Board Games",
    iconColor: Colors.cyan,
    icon: FontAwesomeIcons.chessBoard,
  ),
  Topic(
    id: 17,
    name: "Science & Nature",
    iconColor: Colors.teal,
    icon: FontAwesomeIcons.microscope,
  ),
  Topic(
    id: 18,
    name: "Computer",
    iconColor: Colors.deepPurpleAccent,
    icon: FontAwesomeIcons.laptopCode,
  ),
  Topic(
    id: 19,
    name: "Maths",
    iconColor: Colors.greenAccent,
    icon: FontAwesomeIcons.sortNumericDown,
  ),
  Topic(
    id: 20,
    name: "Mythology",
    iconColor: Colors.redAccent,
    icon: FontAwesomeIcons.book,
  ),
  Topic(
    id: 21,
    name: "Sports",
    iconColor: Colors.limeAccent,
    icon: FontAwesomeIcons.footballBall,
  )
];
