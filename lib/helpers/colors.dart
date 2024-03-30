import 'package:flutter/material.dart';

class ColorItem {
  final String name;
  final Color bgcolor;
  final Color textColor;

  ColorItem(
      {required this.name, required this.bgcolor, required this.textColor});
}

List<ColorItem> colorsLevelBasic = [
  ColorItem(
    name: 'rojo',
    bgcolor: Colors.red,
    textColor: Colors.red,
  ),
  ColorItem(
    name: 'verde',
    bgcolor: Colors.green,
    textColor: Colors.green,
  ),
  ColorItem(
    name: 'azul',
    bgcolor: Colors.blue,
    textColor: Colors.blue,
  ),
  ColorItem(
    name: 'amarillo',
    bgcolor: Colors.yellow,
    textColor: Colors.yellow,
  ),
  ColorItem(
    name: 'blanco',
    bgcolor: Colors.white,
    textColor: Colors.white,
  ),
  ColorItem(
    name: 'negro',
    bgcolor: Colors.black,
    textColor: Colors.black,
  ),
  ColorItem(
    name: 'naranja',
    bgcolor: Colors.orange,
    textColor: Colors.orange,
  ),
  ColorItem(
    name: 'rosa',
    bgcolor: Colors.pink,
    textColor: Colors.pink,
  ),
  ColorItem(
    name: 'violeta',
    bgcolor: Colors.purple,
    textColor: Colors.purple,
  ),
];

List<ColorItem> colorsMedium = [
  ...colorsLevelBasic,
  ColorItem(
    name: 'naranja',
    bgcolor: Colors.orange,
    textColor: Colors.orange,
  ),
  ColorItem(
    name: 'violeta',
    bgcolor: Colors.purple,
    textColor: Colors.purple,
  ),
  ColorItem(
    name: 'rosa',
    bgcolor: Colors.pink,
    textColor: Colors.pink,
  ),
  ColorItem(
    name: 'gris',
    bgcolor: Colors.grey,
    textColor: Colors.grey,
  ),
];

List<ColorItem> colorsHard = [
  ...colorsMedium,
  ColorItem(
    name: 'lima',
    bgcolor: Colors.lime,
    textColor: Colors.lime,
  ),
  ColorItem(
    name: 'cyan',
    bgcolor: Colors.cyan,
    textColor: Colors.cyan,
  ),
  ColorItem(
    name: 'purpura',
    bgcolor: Colors.deepPurple,
    textColor: Colors.deepPurple,
  ),
  ColorItem(
    name: 'fucsia',
    bgcolor: Colors.pinkAccent,
    textColor: Colors.pinkAccent,
  ),
];
