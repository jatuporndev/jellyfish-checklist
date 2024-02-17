import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/presentation/create_room/bloc/create_room_bloc.dart';
import 'package:jellyfish/presentation/util/utill.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final _keyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool validateDetail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Create Room",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: BlocListener<CreateRoomBloc, CreateRoomState>(
        listener: (context, state) {
          if (state.createRoomStateEnum == CreateRoomStateEnum.alreadyHaveRoom) {
            const SnackBar(
              content: Text('already Have Room!'),
            );

          } else if (state.createRoomStateEnum == CreateRoomStateEnum.createRoomSuccessful)  {
            const SnackBar(
              content: Text('Done!'),
            );
            Navigator.of(context).pop();

          } else if (state.createRoomStateEnum == CreateRoomStateEnum.error) {
            const SnackBar(
              content: Text('oh sh!t not good'),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 26, right: 26, top: 16),
            child: Column(
              children: [
                _buildTextField(
                  controller: _keyController,
                  prefixIcon: Icons.kebab_dining,
                  hintText: 'Key',
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _passController,
                  prefixIcon: Icons.self_improvement,
                  hintText: 'Pin',
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _confirmPassController,
                  prefixIcon: Icons.hiking,
                  hintText: 'Confirm Pin',
                  obscureText: true,
                  errorText: validateDetail ? 'Nah, IT DOES NOT MATCH!!' : null,
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: _onSubmitPressed,
                    child: const Text(
                      "Submit!!!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData prefixIcon,
    required String hintText,
    bool obscureText = false,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: Colors.black26,
        errorText: errorText,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  void _onSubmitPressed() {
    dismissKeyboard(context);
    if (_passController.text != _confirmPassController.text) {
      setState(() {
        validateDetail = true;
      });
    } else {
      setState(() {
        validateDetail = false;
      });
      BlocProvider.of<CreateRoomBloc>(context).add(
        SummitCreateRoom(
          keyName: _keyController.text,
          password: _passController.text,
          confirmPassword: _confirmPassController.text,
        ),
      );
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child:   Image.asset(
            'lib/assets/images/loading.gif',
            scale: 1.5,
        ));
      },
    );
  }

  void _dismissLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
