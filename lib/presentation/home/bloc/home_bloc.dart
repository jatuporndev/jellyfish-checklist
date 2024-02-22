import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/data/models/count_data.dart';

import '../../../core/app/app_prefs.dart';
import '../../../domain/use_case/check_list/add_check_list_use_case.dart';
import '../../../domain/use_case/check_list/count_check_list.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppPreferences _appPreferences;
  final CountCheckListUseCase _countCheckListUseCase;

  HomeBloc(this._appPreferences, this._countCheckListUseCase) : super(const HomeState()) {
    on<SignedOut>(signedOut);
    on<CountList>(countList);
  }

  Future<void> signedOut(SignedOut event, Emitter<HomeState> emit) async {
    bool isClear = await _appPreferences.clearAll();
    if (isClear) {
      emit(state.copyWith(homeStateEnum: HomeStateEnum.signedOut));
    } else {
      emit(state.copyWith(homeStateEnum: HomeStateEnum.fail));
    }
  }

  Future<void> countList(CountList event, Emitter<HomeState> emit) async {
    var counting = await _countCheckListUseCase.execute(null);
    counting.fold(
        (left) => emit(state.copyWith(homeStateEnum: HomeStateEnum.fail)),
        (right) =>
            emit(state.copyWith(homeStateEnum: HomeStateEnum.getCountCheckListSuccess, countData: right)));
  }
}
