part of 'sign_in_bloc.dart';

class SigInEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

class EnterRoom extends SigInEvent {
  EnterRoom({
    required this.keyName,
    required this.pin
});
  final String keyName;
  final String pin;

  @override
  List<Object?> get props => [];

}