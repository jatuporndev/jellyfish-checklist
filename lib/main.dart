import 'package:flutter/material.dart';
import 'package:jellyfish/core/app/di.dart';
import 'core/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}

