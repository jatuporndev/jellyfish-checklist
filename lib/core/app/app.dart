import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/core/app/di.dart';
import 'package:jellyfish/core/router/app_generator.dart';
import 'package:jellyfish/presentation/check_room/bloc/check_room_bloc.dart';
import 'package:jellyfish/presentation/home/home.dart';
import 'package:jellyfish/presentation/sign_in/sign_in.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jellyfish',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      onGenerateRoute:  RouteGenerator.getRoute,
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
  late final CheckRoomBloc checkRoomBloc;

  @override
  void initState() {
    super.initState();
    checkRoomBloc = getIt<CheckRoomBloc>();
    checkRoomBloc.add(IsHaveRoom());
  }

  @override
  void dispose() {
    checkRoomBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (_) => getIt<CheckRoomBloc>())],
        child: BlocBuilder<CheckRoomBloc, CheckRoomState>(
          builder: (BuildContext context, CheckRoomState state) {
            if (state.checkState == CheckState.haveRoom) {
              return const Home();
            } else {
              return const Scaffold(
                body: SignIn(),
              );
            }
          },
        ));
  }
}
