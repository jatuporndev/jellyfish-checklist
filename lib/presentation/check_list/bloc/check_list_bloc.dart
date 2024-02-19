import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/domain/use_case/check_list/get_check_list_use_case.dart';

import '../../../data/models/check_list_result.dart';

part 'check_list_event.dart';

part 'check_list_state.dart';

class CheckListBloc extends Bloc<CheckListEvent, CheckListState> {
  final GetCheckListUseCase _getCheckListUseCase;

  CheckListBloc(this._getCheckListUseCase) : super(const CheckListState()) {
    on<GetList>(getList);
  }

  Future<void> getList(GetList event, Emitter<CheckListState> emit) async {
    emit(state.copyWith(listState: ListState.loading));
    var result = await _getCheckListUseCase.execute(null);
    // result.fold(
    //         (left) => {emit(state.copyWith(listState: ListState.error))},
    //         (right) =>  (){
    //    return Right(print("object")) ;
    // });
    if (result.isRight) {
      emit(state.copyWith(listState: ListState.success, checkListResult: result.right));
    }
  }
}
