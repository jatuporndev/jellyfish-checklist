import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/domain/use_case/check_list/get_check_list_use_case.dart';

part 'check_list_event.dart';

part 'check_list_state.dart';

class CheckListBloc extends Bloc<CheckListEvent, CheckListState> {
  final GetCheckListUseCase _getCheckListUseCase;

  CheckListBloc(this._getCheckListUseCase) : super(const CheckListState()) {
    on<GetList>(getList);
  }

  Future<void> getList(GetList event, Emitter<CheckListState> emit) async {
    var result = _getCheckListUseCase.execute(null);
    result.fold((left) => {}, (right) => {});
  }
}
