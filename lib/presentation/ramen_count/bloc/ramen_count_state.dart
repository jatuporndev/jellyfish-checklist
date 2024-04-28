part of 'ramen_count_bloc.dart';

abstract class RamenCountState extends Equatable {
  const RamenCountState();

  @override
  List<Object> get props => [];
}

class InitialState extends RamenCountState {}

class LoadingState extends RamenCountState {}

class UpdatedState extends RamenCountState {}

class DataLoadedState extends RamenCountState {
  final Stream<int> numberOfRamen;

  DataLoadedState(this.numberOfRamen);

  @override
  List<Object> get props => [numberOfRamen];
}

class ErrorState extends RamenCountState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
