import 'package:flutter/material.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final _keyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text("Create Room",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 26, right: 26, top: 16),
          child: Column(
            children: [
              TextField(
                controller: _keyController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.kebab_dining),
                  prefixIconColor: Colors.black26,
                  // border: OutlineInputBorder(),
                  hintText: 'key',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _passController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.self_improvement),
                  prefixIconColor: Colors.black26,
                  // border: OutlineInputBorder(),
                  hintText: 'pin',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _confirmPassController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.hiking),
                  prefixIconColor: Colors.black26,
                  // border: OutlineInputBorder(),
                  hintText: 'confirm pin',
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () => {},
                  child: Text(
                    "Submit!!!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
