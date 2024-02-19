part of 'check_list_bloc.dart';

class CheckListState extends Equatable {
  final ListState listState;
  final Stream<List<CheckListResult>>? checkListResult;

  const CheckListState({this.listState = ListState.initial, this.checkListResult});

  CheckListState copyWith({ListState? listState, Stream<List<CheckListResult>>? checkListResult}) {
    return CheckListState(
        listState: listState ?? this.listState,
        checkListResult: checkListResult ?? this.checkListResult);
  }

  @override
  List<Object?> get props => [listState, checkListResult];
}

enum ListState { initial, success, error, empty, loading }

extension CheckListStateX on ListState {
  bool get initial => this == ListState.initial;

  bool get success => this == ListState.success;

  bool get error => this == ListState.error;

  bool get empty => this == ListState.empty;

  bool get loading => this == ListState.loading;
}
