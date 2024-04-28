
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:jellyfish/core/app/app_prefs.dart';
import 'package:jellyfish/data/repository_imp/check_list_repositort_imp.dart';
import 'package:jellyfish/data/repository_imp/create_room_repository_imp.dart';
import 'package:jellyfish/data/repository_imp/ramen_count_repository_imp.dart';
import 'package:jellyfish/data/repository_imp/sing_in_repository_imp.dart';
import 'package:jellyfish/domain/repository/check_list_repository.dart';
import 'package:jellyfish/domain/repository/create_room_repository.dart';
import 'package:jellyfish/domain/repository/ramen_count_repository.dart';
import 'package:jellyfish/domain/repository/sign_in_repository.dart';
import 'package:jellyfish/domain/use_case/authentication/sing_in_use_case.dart';
import 'package:jellyfish/domain/use_case/check_list/add_check_list_use_case.dart';
import 'package:jellyfish/domain/use_case/check_list/count_check_list.dart';
import 'package:jellyfish/domain/use_case/check_list/delete_check_list_use_case.dart';
import 'package:jellyfish/domain/use_case/check_list/get_check_list_use_case.dart';
import 'package:jellyfish/domain/use_case/check_list/update_check_list_use_case.dart';
import 'package:jellyfish/domain/use_case/ramen_count/get_ramen_use_case.dart';
import 'package:jellyfish/domain/use_case/ramen_count/init_ramen_use_case.dart';
import 'package:jellyfish/domain/use_case/ramen_count/update_ramen_use_case.dart';
import 'package:jellyfish/presentation/check_list/bloc/check_list_bloc.dart';
import 'package:jellyfish/presentation/check_room/bloc/check_room_bloc.dart';
import 'package:jellyfish/presentation/create_room/bloc/create_room_bloc.dart';
import 'package:jellyfish/presentation/home/bloc/home_bloc.dart';
import 'package:jellyfish/presentation/ramen_count/bloc/ramen_count_bloc.dart';
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
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt(), getIt()));

  //CheckList
  getIt.registerFactory<CheckListRepository>(() => CheckListRepositoryImp(getIt(), getIt()));

  getIt.registerFactory<GetCheckListUseCase>(() => GetCheckListUseCase(getIt()));
  getIt.registerFactory<UpdateCheckListUseCase>(() => UpdateCheckListUseCase(getIt()));
  getIt.registerFactory<DeleteCheckListUseCase>(() => DeleteCheckListUseCase(getIt()));
  getIt.registerFactory<AddCheckListUseCase>(() => AddCheckListUseCase(getIt()));
  getIt.registerFactory<CountCheckListUseCase>(() => CountCheckListUseCase(getIt()));

  getIt.registerFactory<CheckListBloc>(() => CheckListBloc(getIt(), getIt(), getIt(), getIt()));

  //ramen
  getIt.registerFactory<RamenCountRepository>(() => RamenRepositoryImp(getIt(), getIt()));
  getIt.registerFactory<GetRamenUseCase>(() => GetRamenUseCase(getIt()));
  getIt.registerFactory<UpdateRamenUseCase>(() => UpdateRamenUseCase(getIt()));
  getIt.registerFactory<InitRamenUseCase>(() => InitRamenUseCase(getIt()));
  getIt.registerFactory<RamenCountBloc>(() => RamenCountBloc(getIt(), getIt(), getIt()));


}