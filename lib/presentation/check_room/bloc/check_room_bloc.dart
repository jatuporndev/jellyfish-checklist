import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jellyfish/core/app/constrains.dart';
import '../../../core/app/app_prefs.dart';

part 'check_room_event.dart';

part 'check_room_state.dart';

class CheckRoomBloc extends Bloc<CheckAuthEvent, CheckRoomState> {
  final AppPreferences _appPreferences;

  CheckRoomBloc(this._appPreferences) : super(const CheckRoomState()) {
    on<IsHaveRoom>(checkRoom);
  }

  Future<void> checkRoom(IsHaveRoom event, Emitter<CheckRoomState> emit) async {
    final key = _appPreferences.getKey();
    if (key != Constants.empty) {
      emit(state.copyWith(checkState: CheckState.haveRoom));
    } else {
      emit(state.copyWith(checkState: CheckState.noRoom));
    }
  }
}
