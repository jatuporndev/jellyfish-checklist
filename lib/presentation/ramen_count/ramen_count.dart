import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/presentation/ramen_count/bloc/ramen_count_bloc.dart';

class RamenCount extends StatefulWidget {
  const RamenCount({Key? key}) : super(key: key);

  @override
  State<RamenCount> createState() => _RamenCountState();
}

class _RamenCountState extends State<RamenCount> {
  bool isDisable = false;
  List<String> text = ["🍜", "🍜"];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RamenCountBloc>(context).add(InitRamen());
    BlocProvider.of<RamenCountBloc>(context).add(GetRamen());
  }

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
                BlocBuilder<RamenCountBloc, RamenCountState>(builder: (context, state) {
                  if (state is LoadingState) {
                    return _buildLoadingWidget();
                  } else if (state is DataLoadedState) {
                    final numberOfRamenStream = state.numberOfRamen;
                    return StreamBuilder(
                        stream: numberOfRamenStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return _buildLoadingWidget();
                          }

                          if (snapshot.hasData) {
                            return buildColumn(snapshot.data);
                          }
                          return Container();
                        });
                  } else {
                    return Container();
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Text(
        "🍜",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Column buildColumn(int? numberOfRamen, {bool inInit = false}) {
    return Column(
      children: [
        Center(
          child: Text(
            numberOfRamen.toString(),
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
                BlocProvider.of<RamenCountBloc>(context).add(UpdateRamen(numberOfRamen, false));
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                BlocProvider.of<RamenCountBloc>(context).add(UpdateRamen(numberOfRamen, true));
              },
              child: Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
        SizedBox(
          height: 48,
        ),
        Wrap(
          children: [
            for (var i = 0; i < (numberOfRamen ?? 0); i++)
              Text(
                "🍜 ",
                style: TextStyle(fontSize: 16),
              )
          ],
        ),
      ],
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

  @override
  void dispose() {
    super.dispose();
  }
}
