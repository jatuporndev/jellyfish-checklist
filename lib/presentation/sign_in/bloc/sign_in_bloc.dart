import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/app_prefs.dart';
import '../../../core/app/constrains.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SigInEvent, SignInState> {
  final AppPreferences _appPreferences;
  SignInBloc(this._appPreferences) : super(const SignInState()) {
    on<EnterRoom>(signIn);
  }

  Future<void> signIn(EnterRoom event, Emitter<SignInState> emit) async {
    await _appPreferences.setKey(event.keyName);
    final key = _appPreferences.getKey();
    if (key != Constants.empty) {
      emit(state.copyWith(signState: SignState.signed));
    } else {
      emit(state.copyWith(signState: SignState.unsigned));
    }
  }

}