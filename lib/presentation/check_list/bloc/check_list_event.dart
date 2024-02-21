part of 'check_list_bloc.dart';

@immutable
abstract class CheckListEvent extends Equatable {}

class GetList extends CheckListEvent {
  @override
  List<Object?> get props => [];
}

class UpdateList extends CheckListEvent {
  final CheckListResult checkListResult;
  UpdateList({required this.checkListResult});

  @override
  List<Object?> get props => [checkListResult];
}
