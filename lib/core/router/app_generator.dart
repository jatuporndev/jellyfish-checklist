import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/core/app/app.dart';
import 'package:jellyfish/presentation/check_list/check_list.dart';
import 'package:jellyfish/presentation/create_room/create_room.dart';
import 'package:jellyfish/presentation/home/home.dart';
import 'package:jellyfish/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:jellyfish/presentation/sign_in/sign_in.dart';

import '../../presentation/home/bloc/home_bloc.dart';
import '../../presentation/util/resources/string_manager.dart';
import '../app/di.dart';
import 'app_router.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.main:
        return MaterialPageRoute(builder: (_) => const MyApp());
      case AppRouter.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeBloc>(),
            child: const Home(),
          ),
        );
      case AppRouter.signIn:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignInBloc>(),
            child: const SignIn(),
          ),
        );
      case AppRouter.createRoom:
        return MaterialPageRoute(builder: (_) => const CreateRoom());
      case AppRouter.checkList:
        return MaterialPageRoute(builder: (_) => const CheckList());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.strNoRouteFound,
          ),
        ),
        body: const Center(
          child: Text(
            AppStrings.strNoRouteFound,
          ),
        ),
      ),
    );
  }
}
