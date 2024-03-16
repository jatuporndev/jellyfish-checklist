import 'package:flutter/material.dart';

class RamenCount extends StatefulWidget {
  const RamenCount({Key? key}) : super(key: key);

  @override
  State<RamenCount> createState() => _RamenCountState();
}

class _RamenCountState extends State<RamenCount> {
  bool isDisable = false;
  List<String> text = ["🍜", "🍜"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff4ed),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context),
                SizedBox(height: 18),
                Center(
                  child: Text(
                    "98",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 110, color: Colors.orange),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      onPressed: () {
                        setState(() {
                          text.removeAt(0);
                        });

                      },
                      child: Icon(Icons.remove, color: Colors.white),
                    ),
                    Column(
                      children: [
                        Text("🍜", style: TextStyle(fontSize: 24)),
                        Text("Ramen!", style: TextStyle(color: Colors.orange[300])),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                      onPressed: () {
                        setState(() {
                          text.insert(0, "🍜");
                        });
                      },
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                  Wrap(
                    children:[
                        for(var i in text)
                         Text(" $i " ,style: TextStyle(fontSize: 16),)
                      ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios_new, color: Colors.orange),
          SizedBox(width: 8),
          Text(
            "Ramen count",
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
