import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/core/app/di.dart';
import 'package:jellyfish/core/router/app_generator.dart';
import 'package:jellyfish/presentation/check_room/bloc/check_room_bloc.dart';
import 'package:jellyfish/presentation/home/bloc/home_bloc.dart';
import 'package:jellyfish/presentation/home/home.dart';
import 'package:jellyfish/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:jellyfish/presentation/sign_in/sign_in.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jellyfish',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent)
        //     .copyWith(background: Colors.black54),
        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(color: Colors.white),
        //   bodyMedium: TextStyle(color: Colors.white),
        // ),
        // inputDecorationTheme: const InputDecorationTheme(
        //   hintStyle: TextStyle(color: Colors.white70),
        // ),
        // iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => getIt<CheckRoomBloc>()..add(IsHaveRoom())),
        BlocProvider(create: (_) => getIt<SignInBloc>()),
        BlocProvider(create: (_) => getIt<HomeBloc>()),
      ], child: const MyHomePage()),
      onGenerateRoute: RouteGenerator.getRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckRoomBloc, CheckRoomState>(
      builder: (BuildContext context, CheckRoomState state) {
        if (state.checkState == CheckState.haveRoom) {
          return const Home();
        } else {
          return const SignIn();
        }
      },
    );
  }
}
