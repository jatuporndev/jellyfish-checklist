import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:jellyfish/core/router/app_router.dart';
import 'package:jellyfish/presentation/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (BuildContext context, state) {
          if(state.homeStateEnum == HomeStateEnum.signedOut) {
            Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.signIn, (route) => false);
          }
        },
        child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                IconButton(
                    onPressed: () =>
                    {
                      showModalBottomSheet(
                        context: context,
                        //backgroundColor: Colors.white,
                        //barrierColor: Colors.deepPurpleAccent[100],
                        clipBehavior: Clip.antiAlias,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return GiffyBottomSheet.image(
                            const Image(image: AssetImage(
                                'lib/assets/images/signedout.gif')),
                            title: const Text(
                              'DO YOU WANT TO LOG OUT!?',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),

                            content: const Text(
                              'This cat is shocked that you are leaving the room. Are you really sure? Think again.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            actions: [
                              SizedBox(
                                width: 148,
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black38,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12), // <-- Radius
                                    ),
                                  ),
                                  onPressed: () => {
                                    Navigator.pop(context, 'CANCEL'),
                                  },
                                  child: const Text("NOPE",style: TextStyle(color: Colors.white),),
                                ),
                              ),
                              SizedBox(
                                width: 148,
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurpleAccent[100],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => {
                                    homeBloc.add(SignedOut()),
                                  },
                                  child: const Text("YEP",style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    },
                    icon: const Icon(Icons.exit_to_app)),
              ],
            )),
      ),
    );
  }
}
