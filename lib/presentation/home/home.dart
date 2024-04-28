import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:jellyfish/core/router/app_router.dart';
import 'package:jellyfish/data/models/count_data.dart';
import 'package:jellyfish/presentation/home/bloc/home_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../util/resources/color_manager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  late final HomeBloc homeBloc;
  final isLogoutButtonHidden = false;
  final _cardSide = 245.0;

  int totalCheckList = 0;
  int countCheckList = 0;
  double checkListPercent = 0.0;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(CountList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<HomeBloc, HomeState>(
        listener: (BuildContext context, state) {
          if (state.homeStateEnum == HomeStateEnum.signedOut) {
            Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.signIn, (route) => false);
          }
          if (state.homeStateEnum == HomeStateEnum.getCountCheckListSuccess) {
            setUpCheckListCard(state.countData);
          }
        },
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Emm..",
                    style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  //IconButton(onPressed: () {}, icon: Icon(Icons.settings))
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: _cardSide,
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                shadowColor: ColorsManager.mainColor,
                color: ColorsManager.mainColor,
                child: GestureDetector(
                  onTap: () async {
                    Object? refresh = await Navigator.of(context).pushNamed(AppRouter.checkList);
                    if (refresh == "refresh") {
                      homeBloc.add(CountList());
                    }
                  },
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          // Adjust the radius to match the Card's radius
                          child: Image.asset(
                            "lib/assets/images/cat_title.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Card Content
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "CheckList",
                                      style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      "Where?",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                CircularPercentIndicator(
                                  radius: 34.0,
                                  lineWidth: 8.0,
                                  percent: checkListPercent,
                                  animation: true,
                                  animationDuration: 900,
                                  center: Text(
                                    "${(checkListPercent * 100).toInt()}%",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  progressColor: Colors.white,
                                  backgroundColor: Colors.black38,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "$countCheckList of $totalCheckList",
                                  style: const TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //ramen card
            Container(
              width: MediaQuery.of(context).size.width,
              height: _cardSide,
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                // shadowColor: ColorsManager.mainColor,
                color: Colors.orangeAccent,
                child: GestureDetector(
                  onTap: () async {
                    Navigator.of(context)
                        .pushNamed(AppRouter.ramenCount);
                  },
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          // Adjust the radius to match the Card's radius
                          child: Image.asset(
                            "lib/assets/images/ramen_card.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Card Content
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Ramen count",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                "Ramen today?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "🍜",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                  )
                                ],
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (false)
              Container(
                width: MediaQuery.of(context).size.width,
                height: _cardSide,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.blueAccent[100],
                  color: Colors.blueAccent[100],
                  child: GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        // Background Image
                        Positioned.fill(
                          child: Image.asset(
                            "lib/assets/images/water_title.png",
                            fit: BoxFit.cover,
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
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  CircularPercentIndicator(
                                    radius: 34.0,
                                    lineWidth: 8.0,
                                    percent: 0.3,
                                    animation: true,
                                    animationDuration: 900,
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
                              const Spacer(),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "2 of 23",
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                showLogoutPopup(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 64,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.black,
                  child: Center(
                    child: const Text(
                      "IM OUT!",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void setUpCheckListCard(CountData? countData) {
    var count = countData?.count ?? 0;
    var total = countData?.total ?? 0;
    double percent = (total > 0) ? (count / total) : 0.0;
    setState(() {
      countCheckList = countData?.count ?? 0;
      totalCheckList = countData?.total ?? 0;
      checkListPercent = percent;
    });
  }

  void showLogoutPopup(BuildContext context) {
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
          const Image(image: AssetImage('lib/assets/images/signedout.gif')),
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
              width: 146,
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
                child: const Text("YEP", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }
}
