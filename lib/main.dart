import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jellyfish/core/app/di.dart';
import 'core/app/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initAppModule();
  runApp(const MyApp());
}

