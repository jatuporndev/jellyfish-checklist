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

class DeleteList extends CheckListEvent {
  final CheckListResult checkListResult;
  DeleteList({required this.checkListResult});

  @override
  List<Object?> get props => [checkListResult];
}
class AddList extends CheckListEvent {
  final CheckListResult checkListResult;
  AddList({required this.checkListResult});

  @override
  List<Object?> get props => [checkListResult];
}

