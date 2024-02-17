import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/data/models/room_request.dart';
import 'package:jellyfish/domain/use_case/authentication/sing_in_use_case.dart';

import '../../../core/app/app_prefs.dart';
import '../../../core/app/constrains.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SigInEvent, SignInState> {
  final SignInUseCase _signInUseCase;
  SignInBloc(this._signInUseCase)
      : super(const SignInState()) {
    on<EnterRoom>(signIn);
  }

  Future<void> signIn(EnterRoom event, Emitter<SignInState> emit) async {
    emit(state.copyWith(signState: SignState.loading));
    var request = RoomRequest(key: event.keyName, pin: event.pin);
    var result = await _signInUseCase.execute(request);
    result.fold(
        (left) => {emit(state.copyWith(signState: SignState.unsigned))},
        (right)  async => {
              if (right)
                {emit(state.copyWith(signState: SignState.signed))}
              else
                {emit(state.copyWith(signState: SignState.unsigned))}
            });
  }

}
