import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:jellyfish/core/router/app_router.dart';
import 'package:jellyfish/presentation/home/bloc/home_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../util/resources/color_manager.dart';

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
          if (state.homeStateEnum == HomeStateEnum.signedOut) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRouter.signIn, (route) => false);
          }
        },
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logoutIcon(context),
            // Container(
            //   height: (MediaQuery.of(context).size.height * 0.25),
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     color: ColorsManager.mainColor,
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(16.0),
            //       bottomRight: Radius.circular(16.0),
            //     ),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       logoutIcon(context),
            //     ],
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 8,
                shadowColor: Colors.amber,
                color: Colors.deepPurpleAccent[100],
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: Image.asset(
                          "lib/assets/images/cat_title.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      // Card Content
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "CheckList",
                                  style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                CircularPercentIndicator(
                                  radius: 34.0,
                                  lineWidth: 8.0,
                                  percent: 0.3,
                                  center: Text(
                                    "30%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  progressColor: Colors.white,
                                  backgroundColor: Colors.black38,
                                ),
                              ],
                            ),
                          const Text(
                            "2 of 23",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18
                            ),
                          )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 8,
                shadowColor: Colors.amber,
                color: Colors.blueAccent[100],
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: Image.asset(
                          "lib/assets/images/water_title.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      // Card Content
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Achievement",
                                  style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                CircularPercentIndicator(
                                  radius: 34.0,
                                  lineWidth: 8.0,
                                  percent: 0.3,
                                  center: Text(
                                    "10%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  progressColor: Colors.white,
                                  backgroundColor: Colors.black38,
                                ),
                              ],
                            ),
                            const Text(
                              "2 of 23",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18
                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        )),
      ),
    );
  }

  IconButton logoutIcon(BuildContext context) {
    return IconButton(
        onPressed: () => {
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
                    const Image(
                        image: AssetImage('lib/assets/images/signedout.gif')),
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
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          onPressed: () => {
                            Navigator.pop(context, 'CANCEL'),
                          },
                          child: const Text(
                            "NOPE",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 148,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => {
                            homeBloc.add(SignedOut()),
                          },
                          child: const Text("YEP",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            },
        icon: const Icon(Icons.exit_to_app));
  }
}
