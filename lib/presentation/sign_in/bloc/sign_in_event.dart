part of 'sign_in_bloc.dart';

class SigInEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

class EnterRoom extends SigInEvent {
  EnterRoom({
    required this.keyName
});
  final String keyName;

  @override
  List<Object?> get props => [keyName];

}