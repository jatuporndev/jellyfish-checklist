import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/presentation/create_room/create_room.dart';
import 'package:jellyfish/presentation/home/home.dart';
import 'package:jellyfish/presentation/sign_in/sign_in.dart';

import '../../presentation/util/resources/string_manager.dart';
import '../app/di.dart';
import 'app_router.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRouter.mainMenu:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //       create: (context) => instance<LoginBloc>(),
      //       child: const MainMenu(),
      //     ),
      //   );
      // case AppRouter.login:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //       create: (context) => instance<LoginBloc>(),
      //       child: const Login(),
      //     ),
      //   );
      case AppRouter.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case AppRouter.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case AppRouter.createRoom:
        return MaterialPageRoute(builder: (_) => const CreateRoom());
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
