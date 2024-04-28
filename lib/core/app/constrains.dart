import 'package:cloud_firestore/cloud_firestore.dart';

class Constants {
  Constants._();
  static final Constants _instance = Constants._();

  // Factory method to return the single instance
  factory Constants() => _instance;

  static const String baseUrl = "";
  static const String empty = "";


  //database key
  static const String room = 'room';
  static const String checkList = 'check_list';
  static const String ramenCount = 'ramen_count';
  static const String numberOfRamen = 'numberOfRamen';
  static const String docRamen = 'c';
}