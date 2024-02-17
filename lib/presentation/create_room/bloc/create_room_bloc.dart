import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/data/models/room_request.dart';

import '../../../core/app/app_prefs.dart';
import '../../../domain/use_case/authentication/create_room_use_case.dart';

part 'create_room_event.dart';

part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  final AppPreferences _appPreferences;
  final CreateRoomUseCase _createRoomUseCase;

  CreateRoomBloc(this._appPreferences, this._createRoomUseCase)
      : super(const CreateRoomState()) {
    on<SummitCreateRoom>(summitRoom);
  }

  Future<void> summitRoom(
      SummitCreateRoom event, Emitter<CreateRoomState> emit) async {
    // emit(state.copyWith(createRoomStateEnum: CreateRoomStateEnum.loading));
    final result = await _createRoomUseCase
        .execute(RoomRequest(key: event.keyName, pin: event.password));
    result.fold(
        (left) => {
              if (left.code == 400)
                {
                  emit(state.copyWith(
                      createRoomStateEnum: CreateRoomStateEnum.alreadyHaveRoom))
                }
              else
                {
                  emit(state.copyWith(
                      createRoomStateEnum: CreateRoomStateEnum.error))
                }
            },
        (right) => {
              emit(state.copyWith(
                  createRoomStateEnum:
                      CreateRoomStateEnum.createRoomSuccessful))
            });
  }
}
