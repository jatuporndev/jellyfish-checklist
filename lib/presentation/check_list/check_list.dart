import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckList extends StatefulWidget {
  const CheckList({Key? key}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
   bool is_check = true;
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
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child:  Row(
                        children: [
                          Icon(Icons.arrow_back_ios_new,
                              color: Colors.deepPurpleAccent),
                          Text(
                            "CheckList",
                            style: TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.catching_pokemon,
                          color: Colors.deepPurpleAccent)),
                  IconButton(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.add, color: Colors.deepPurpleAccent))
                ],
              ),
            ),
            checkList("ตี๋น้อย"),
            checkList("ตี๋น้อย"),
            checkList("ตี๋น้อย"),
            checkList("ตี๋น้อย"),

          ],
        ),
      ),
    );
  }

  Container checkList(String name) {
    return Container(
            padding: const EdgeInsets.only(left: 26, right: 16),
            child: Row(
              children: [
                Checkbox(
                  value: is_check,
                  shape: const CircleBorder(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (bool? value) {
                    setState(() {
                      is_check = !is_check;

                    });
                  },
                ),
                Text(name,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
              ],
            )
          );
  }
}
