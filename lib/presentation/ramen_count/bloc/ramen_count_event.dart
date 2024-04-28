
part of 'ramen_count_bloc.dart';

class RamenCountEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

class GetRamen extends RamenCountEvent {
  @override
  List<Object?> get props => [];
}

class InitRamen extends RamenCountEvent {
  @override
  List<Object?> get props => [];

}

class UpdateRamen extends RamenCountEvent {
  final int? numberOfRamen;
  final bool isIncrease;
  UpdateRamen(this.numberOfRamen, this.isIncrease);

  @override
  List<Object?> get props => [numberOfRamen];

}