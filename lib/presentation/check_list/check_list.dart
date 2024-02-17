import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/resources/color_manager.dart';

class CheckList extends StatefulWidget {
  const CheckList({Key? key}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  bool _isCheck = true;
  bool _isEdit = false;
  bool validateDetail = false;
  final detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:  Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new,
                            color:  ColorsManager.mainColor),
                        Text(
                          "CheckList",
                          style: TextStyle(
                              color:  ColorsManager.mainColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _isEdit = !_isEdit;
                        });
                      },
                      icon:  Icon(Icons.catching_pokemon,
                          color:  ColorsManager.mainColor)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          validateDetail = false;
                        });
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Wrap(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: sheetDia(context, detailController),
                                  ),
                                ],
                              );
                            });
                      },
                      icon:
                           Icon(Icons.add, color: ColorsManager.mainColor))
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            checkList(
                "ตี๋น้อยตี๋น้อยตี๋น้อยตี๋น้อยตี๋น้อยตี๋น้อยตี๋น้อยตี๋น้อยตี๋น้อยตี๋น้อยตี๋น้อย"),
            
            checkList("ตี๋น้อย"),
            checkList("ตี๋น้อย"),
            checkList("ตี๋น้อย"),
          ],
        ),
      ),
    );
  }

  Container checkList(String name) {
    double size = 25.0;
    return Container(
      padding: const EdgeInsets.only(left: 28, right: 16, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 1.2,
            child: SizedBox(
              width: size,
              height: size,
              child: Checkbox(
                value: _isCheck,
                activeColor:  ColorsManager.mainColor,
                side: const BorderSide(color: Colors.black38),
                shape: const CircleBorder(),
                onChanged: (bool? value) {
                  setState(() {
                    _isCheck = !_isCheck;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          if (_isEdit) ...[
            const SizedBox(
              width: 8,
            ),
            Container(
              decoration:  BoxDecoration(
                  color: ColorsManager.mainColor,
                  border: Border.all(color: (ColorsManager.mainColor)!,),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3.0),
                  )),
              padding: const EdgeInsets.all(4),
              child: const Text("  EDIT  ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
            const SizedBox(
              width: 2,
            ),
            Container(
              decoration:   BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: (ColorsManager.mainColor)!,),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3.0),
                  )),
              padding: const EdgeInsets.all(4),
              child: Text("DELETE",
                  style: TextStyle(
                      color: ColorsManager.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
          ]
        ],
      ),
    );
  }

  SizedBox sheetDia(
      BuildContext context, TextEditingController detailController) {
    return SizedBox(
      height: 175,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close)),
              const Text("What?"),
              IconButton(
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  saveData();
                },
                icon: const Icon(Icons.done),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              maxLength: 24,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'What?',
                hintText: 'What?',
                errorText: validateDetail ? 'Nah,It Can\'t Be Empty' : null,
              ),
              controller: detailController,
              autofocus: false,
              onEditingComplete: () {
                saveData();
              },
            ),
          )
        ],
      ),
    );
  }

  void saveData() {
    setState(() {
    if(detailController.text.isEmpty) {
        validateDetail = true;
    } else {
      validateDetail = false;
    }
    });
  }
}
