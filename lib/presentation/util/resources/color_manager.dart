import 'package:flutter/material.dart';

class ColorsManager {
  ColorsManager._();

  // Singleton instance
  static final ColorsManager _instance = ColorsManager._();

  // Getter to access the singleton instance
  factory ColorsManager() => _instance;

  static var mainColor = Colors.deepPurpleAccent[100];

}