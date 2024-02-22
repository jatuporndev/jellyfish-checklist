import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/domain/use_case/check_list/add_check_list_use_case.dart';
import 'package:jellyfish/domain/use_case/check_list/delete_check_list_use_case.dart';
import 'package:jellyfish/domain/use_case/check_list/get_check_list_use_case.dart';
import 'package:jellyfish/domain/use_case/check_list/update_check_list_use_case.dart';

import '../../../data/models/check_list_result.dart';

part 'check_list_event.dart';

part 'check_list_state.dart';

class CheckListBloc extends Bloc<CheckListEvent, CheckListState> {
  final GetCheckListUseCase _getCheckListUseCase;
  final UpdateCheckListUseCase _updateCheckListUseCase;
  final DeleteCheckListUseCase _deleteCheckListUseCase;
  final AddCheckListUseCase _addCheckListUseCase;

  CheckListBloc(this._getCheckListUseCase, this._updateCheckListUseCase, this._deleteCheckListUseCase,
      this._addCheckListUseCase)
      : super(const CheckListState()) {
    on<GetList>(getList);
    on<UpdateList>(updateList);
    on<DeleteList>(deleteList);
    on<AddList>(addList);

  }

  Future<void> getList(GetList event, Emitter<CheckListState> emit) async {
    emit(state.copyWith(listState: ListState.loading));
    var result = await _getCheckListUseCase.execute(null);
    result.fold((left) => {emit(state.copyWith(listState: ListState.error))},
        (right) => {emit(state.copyWith(listState: ListState.success, checkListResult: result.right))});
  }

  Future<void> updateList(UpdateList event, Emitter<CheckListState> emit) async {
    var result = await _updateCheckListUseCase.execute(event.checkListResult);
    result.fold((left) => emit(state.copyWith(listState: ListState.error)),
        (right) => emit(state.copyWith(listState: ListState.success)));
  }

  Future<void> deleteList(DeleteList event, Emitter<CheckListState> emit) async {
    var result = await _deleteCheckListUseCase.execute(event.checkListResult);
    result.fold((left) => emit(state.copyWith(listState: ListState.error)),
        (right) => emit(state.copyWith(listState: ListState.success)));
  }

  Future<void> addList(AddList event, Emitter<CheckListState> emit) async {
    var result = await _addCheckListUseCase.execute(event.checkListResult);
    result.fold((left) => emit(state.copyWith(listState: ListState.error)),
            (right) => emit(state.copyWith(listState: ListState.success)));
  }
}
