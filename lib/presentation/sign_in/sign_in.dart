import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    height: 24,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 23, right: 23),
                    child: SizedBox(
                      height: 56,
                      child: TextField(
                        decoration: InputDecoration(
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
                      Navigator.of(context).pushNamed(AppRouter.createRoom)
                    },
                      child: const Text("let's go"),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("or"),
                      TextButton(onPressed: () => {}, child: Text("create room!"))
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
