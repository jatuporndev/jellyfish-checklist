import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/app_prefs.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppPreferences _appPreferences;

  HomeBloc(this._appPreferences) : super(const HomeState()) {
    on<SignedOut>(signedOut);
  }

  Future<void> signedOut(SignedOut event, Emitter<HomeState> emit) async {
    bool isClear = await _appPreferences.clearAll();
    if (isClear) {
      emit(state.copyWith(homeStateEnum: HomeStateEnum.signedOut));
    } else {
      emit(state.copyWith(homeStateEnum: HomeStateEnum.fail));
    }
  }
}
