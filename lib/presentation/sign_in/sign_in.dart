import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/presentation/sign_in/bloc/sign_in_bloc.dart';

import '../../core/router/app_router.dart';
import '../util/utill.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _keyController = TextEditingController();
  final _pinController = TextEditingController();
  late final SignInBloc signInBloc;
  bool isPin = false;
  bool isError = false;
  bool isLoading = false;

  @override
  void initState() {
    signInBloc = BlocProvider.of<SignInBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocListener<SignInBloc, SignInState>(
        listener: (BuildContext context, state) {
          if (state.signState == SignState.signed) {
            Navigator.of(context).popAndPushNamed(AppRouter.home);
          } else if (state.signState == SignState.loading) {
            setState(() {
              isLoading = true;
            });
          } else if (state.signState == SignState.unsigned) {
            setState(() {
              isError = true;
              isLoading = false;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/assets/images/title.png",
                  scale: 4,
                  color: (isError) ? Colors.red : Colors.black,
                ),
                const SizedBox(height: 16,),
                const Text(
                  "ROOOOOOM!",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                ),
                const Text("Hi, Enter Your key room"),
                const SizedBox(
                  height: 34,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26),
                  child: SizedBox(
                    height: 56,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          if (text.isNotEmpty) {
                            isPin = true;
                          } else {
                            isPin = false;
                          }
                        });
                      },
                      controller: _keyController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.kebab_dining),
                          prefixIconColor: Colors.black26,
                          hintText: "room id"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    // Animation curve
                    height: isPin ? 56 : 0,
                    child: TextField(
                      enabled: isPin,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _pinController,
                      decoration: InputDecoration(
                        prefixIcon:
                            isPin ? const Icon(Icons.self_improvement) : null,
                        prefixIconColor: Colors.black26,
                        hintText: isPin ? "pin" : "",
                      ),
                    ),
                  ),
                ),
                if (isError)
                  const Text(
                    "!?",
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () => {
                        if (!isLoading)
                          {
                            dismissKeyboard(context),
                            signInBloc.add(EnterRoom(
                                keyName: _keyController.text,
                                pin: _pinController.text))
                          }
                      },
                      child: isLoading
                          ? const SizedBox(
                              width: 26,
                              height: 26,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              "Let's Go",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "or you can",
                      style: TextStyle(fontSize: 12),
                    ),
                    TextButton(
                        onPressed: () => {
                              Navigator.of(context)
                                  .pushNamed(AppRouter.createRoom)
                            },
                        child: const Text("create room!",
                            style: TextStyle(fontSize: 12)))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
