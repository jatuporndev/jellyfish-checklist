import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/presentation/sign_in/bloc/sign_in_bloc.dart';

import '../../core/router/app_router.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _keyController = TextEditingController();
  late final SignInBloc signInBloc;


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
              } else if(state.signState == SignState.unsigned) {
                print("error");
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Roommmm",
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                    ),
                    const Text("Hi, Enter Your key room"),
                    const SizedBox(
                      height: 52,
                    ),
                     Padding(
                      padding: const EdgeInsets.only(left: 23, right: 23),
                      child: SizedBox(
                        height: 56,
                        child: TextField(
                          controller: _keyController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key_outlined),
                            prefixIconColor: Colors.deepPurpleAccent,
                            border: OutlineInputBorder(),
                            hintText: 'Enter a key hereeeee!',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    SizedBox(
                      width: 185,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        onPressed: () => {
                          signInBloc.add(EnterRoom(keyName: _keyController.text))
                      },
                        child: const Text("let's go"),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("or you can",style: TextStyle(fontSize: 12),),
                        TextButton(onPressed: () => {
                          Navigator.of(context).pushNamed(AppRouter.createRoom)
                        }, child: const Text("create room!",style: TextStyle(fontSize: 12)))
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
