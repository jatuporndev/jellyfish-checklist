part of 'check_room_bloc.dart';

class CheckRoomState extends Equatable {
  final CheckState checkState;
  const CheckRoomState({this.checkState = CheckState.initial});

  CheckRoomState copyWith({
    CheckState? checkState,
  }) {
    return CheckRoomState(checkState: checkState ?? this.checkState);
  }

  @override
  List<Object?> get props => [checkState];
}

enum CheckState { initial, noRoom, haveRoom }

extension CheckRoomStateX on CheckState {
  bool get initial => this == CheckState.initial;
  bool get noRoom => this == CheckState.noRoom;
  bool get haveRoom => this == CheckState.haveRoom;
}