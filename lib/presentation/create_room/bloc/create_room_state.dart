part of 'create_room_bloc.dart';

class CreateRoomState extends Equatable {
  final CreateRoomStateEnum createRoomStateEnum;
  const CreateRoomState({this.createRoomStateEnum = CreateRoomStateEnum.initial});

  CreateRoomState copyWith({
  CreateRoomStateEnum? createRoomStateEnum,
}) {
    return CreateRoomState(createRoomStateEnum: createRoomStateEnum ?? this.createRoomStateEnum);
}

  @override
  List<Object?> get props => [];

}

enum CreateRoomStateEnum {initial, createRoomSuccessful, alreadyHaveRoom, passwordNotMatch}

extension CreateRoomStateX on CreateRoomStateEnum {
  bool get initial => this == CreateRoomStateEnum.initial;
  bool get createRoom => this == CreateRoomStateEnum.createRoomSuccessful;
  bool get alreadyHaveRoom => this == CreateRoomStateEnum.alreadyHaveRoom;
  bool get passwordNotMatch => this == CreateRoomStateEnum.passwordNotMatch;
}