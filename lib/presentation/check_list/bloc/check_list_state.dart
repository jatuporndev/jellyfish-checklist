
part of 'check_list_bloc.dart';

class CheckListState extends Equatable{
  final ListState listState;
  const CheckListState({this.listState = ListState.initial});

  CheckListState copyWith({
    ListState? listState
}) {
    return CheckListState(listState: listState ?? this.listState);
  }

  @override
  List<Object?> get props => throw [listState];

}

enum ListState {initial, success, error, empty}

extension CheckListStateX on ListState {
  bool get initial => this == ListState.initial;
  bool get success => this == ListState.initial;
  bool get error => this == ListState.error;
  bool get empty => this == ListState.empty;
}
