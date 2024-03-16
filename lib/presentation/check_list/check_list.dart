import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jellyfish/presentation/check_list/bloc/check_list_bloc.dart';

import '../../data/models/check_list_result.dart';
import '../../data/models/submit_type_enum.dart';
import '../util/resources/color_manager.dart';

class CheckList extends StatefulWidget {
  const CheckList({Key? key}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  bool validateDetail = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckListBloc>(context).add(GetList());
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _buildBackButton(context),
                  const Spacer(),
                  _buildAddItemButton(context),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            BlocBuilder<CheckListBloc, CheckListState>(
              builder: (context, state) {
                if (state.listState == ListState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.listState == ListState.error) {
                  return const Center(child: Text("emmm broken"));
                } else {
                  return StreamBuilder(
                    stream: state.checkListResult,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var count = snapshot.data?.length ?? 0;
                        if (count > 0) {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = snapshot.data?[index];
                              return checklistItem("${data?.title}", data?.isCheck, data?.id);
                            },
                          );
                        } else {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "lib/assets/images/title.png",
                                  scale: 4,
                                  color: Colors.black26,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text("nothing here"),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                ),
                              ],
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Container checklistItem(String name, bool? isChecked, String? id) {
    double size = 25.0;

    return Container(
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              flex: 1,
              onPressed: (context) {
                setText(name);
                _showEditBottomSheet(context, name, id, SubmitTypeEnum.edit);
              },
              backgroundColor: ColorsManager.mainColor!,
              foregroundColor: Colors.white,
              icon: Icons.edit,
            ),
            SlidableAction(
              flex: 1,
              onPressed: (context) {
                BlocProvider.of<CheckListBloc>(context)
                    .add(DeleteList(checkListResult: CheckListResult(id: id)));
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete_forever,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<CheckListBloc>(context)
                .add(UpdateList(checkListResult: CheckListResult(id: id, isCheck: !isChecked!)));
          },
          child: Container(
            padding: const EdgeInsets.only(left: 28, right: 16, bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: Checkbox(
                      value: isChecked,
                      activeColor: ColorsManager.mainColor,
                      side: const BorderSide(color: Colors.black38),
                      shape: const CircleBorder(),
                      onChanged: (value) {
                        BlocProvider.of<CheckListBloc>(context)
                            .add(UpdateList(checkListResult: CheckListResult(id: id, isCheck: value)));
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _showEditBottomSheet(BuildContext context, String? title, String? id, SubmitTypeEnum submitTypeEnum) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.9, // Adjust the height as needed
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: sheetDia(context, submitTypeEnum, title: title, id: id),
          ),
        );
      },
    );
  }

  SizedBox sheetDia(BuildContext context2, SubmitTypeEnum submitTypeEnum, {String? title, String? id}) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 6),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorsManager.mainColor,
                ),
                height: 6,
                width: 44,
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Where?",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                maxLength: 120,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Where?',
                  hintText: 'Where?',
                  errorText: validateDetail ? 'Nah,It Can\'t Be Empty' : null,
                ),
                controller: _textEditingController,
                autofocus: false,
                onEditingComplete: () {
                  saveData();
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                if (submitTypeEnum == SubmitTypeEnum.add) {
                  if (!_textEditingController.text.isEmpty) {
                    BlocProvider.of<CheckListBloc>(context)
                        .add(AddList(checkListResult: CheckListResult(title: _textEditingController.text)));
                  }
                } else {
                  if (_textEditingController.text.isEmpty) {
                    BlocProvider.of<CheckListBloc>(context)
                        .add(DeleteList(checkListResult: CheckListResult(id: id)));
                  } else {
                    BlocProvider.of<CheckListBloc>(context).add(UpdateList(
                        checkListResult: CheckListResult(id: id, title: _textEditingController.text)));
                  }
                }

                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context2).size.width,
                height: 66,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: ColorsManager.mainColor,
                  child: const Center(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop("refresh");
      },
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios_new, color: ColorsManager.mainColor),
          SizedBox(width: 8),
          Text(
            "CheckList",
            style: TextStyle(
              color: ColorsManager.mainColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddItemButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        setText("");
        _showEditBottomSheet(context, "", "", SubmitTypeEnum.add);
      },
      icon: Icon(Icons.add, color: ColorsManager.mainColor),
    );
  }

  void saveData() {
    setState(() {
      if (_textEditingController.text.isEmpty) {
        validateDetail = true;
      } else {
        validateDetail = false;
      }
    });
  }

  void setText(String data) {
    setState(() {
      _textEditingController.text = data;
    });
  }
}
