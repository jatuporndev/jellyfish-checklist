
part of 'ramen_count_bloc.dart';

class RamenCountEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

class GetRamen extends RamenCountEvent {
  @override
  List<Object?> get props => [];

}

class UpdateRamen extends RamenCountEvent {
  final int numberOfRamen;
  UpdateRamen(this.numberOfRamen);

  @override
  List<Object?> get props => [numberOfRamen];

}