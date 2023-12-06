import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/app_prefs.dart';

part 'create_room_event.dart';

part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  final AppPreferences _appPreferences;

  CreateRoomBloc(this._appPreferences) : super(const CreateRoomState()) {
    on<SummitCreateRoom>(summitRoom);
  }

  Future<void> summitRoom(SummitCreateRoom event, Emitter<CreateRoomState> emit) async {

  }
}
