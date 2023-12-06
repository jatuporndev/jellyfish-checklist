part of 'create_room_bloc.dart';

class CreateRoomEvent extends Equatable {

  @override
  List<Object?> get props => [];

}

class SummitCreateRoom extends CreateRoomEvent {
  final String keyName;
  final String password;
  final String confirmPassword;
  SummitCreateRoom({required this.keyName, required this.password, required this.confirmPassword});

  @override
  List<Object?> get props => [keyName, password, confirmPassword];
}