
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:jellyfish/core/app/app_prefs.dart';
import 'package:jellyfish/data/repository_imp/create_room_repository_imp.dart';
import 'package:jellyfish/data/repository_imp/sing_in_repository_imp.dart';
import 'package:jellyfish/domain/repository/create_room_repository.dart';
import 'package:jellyfish/domain/repository/sign_in_repository.dart';
import 'package:jellyfish/domain/use_case/authentication/sing_in_use_case.dart';
import 'package:jellyfish/presentation/check_room/bloc/check_room_bloc.dart';
import 'package:jellyfish/presentation/create_room/bloc/create_room_bloc.dart';
import 'package:jellyfish/presentation/home/bloc/home_bloc.dart';
import 'package:jellyfish/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/use_case/authentication/create_room_use_case.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {

  //sharedPreferences di
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));

  //google
  final firebaseFirestore = FirebaseFirestore.instance;
  getIt.registerLazySingleton<FirebaseFirestore>(() => firebaseFirestore);


  //check room
  getIt.registerFactory<CheckRoomBloc>(() => CheckRoomBloc(getIt()));

  //createRoom
  getIt.registerFactory<CreateRoomRepository>(() => CreateRoomRepositoryImp(getIt()));
  getIt.registerFactory<CreateRoomUseCase>(() => CreateRoomUseCase(getIt()));
  getIt.registerFactory<CreateRoomBloc>(() => CreateRoomBloc(getIt(), getIt()));

  //signIn
  getIt.registerFactory<SignInRepository>(() => SignInRepositoryImp(getIt(), getIt()));
  getIt.registerFactory<SignInUseCase>(() => SignInUseCase(getIt()));
  getIt.registerFactory<SignInBloc>(() => SignInBloc(getIt()));

  //Home
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));

}