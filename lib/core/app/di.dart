
import 'package:get_it/get_it.dart';
import 'package:jellyfish/core/app/app_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {

  //sharedPreferences di
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
}