part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  final SignState signState;
  const SignInState({this.signState = SignState.initial});


  SignInState copyWith({
    SignState? signState,
  }) {
    return SignInState(signState: signState ?? this.signState);
  }

  @override
  List<Object?> get props =>  [signState];
}

enum SignState  {initial, signed, unsigned, loading}

extension SignStateX on SignState {
bool get initial => this == SignState.initial;
bool get noRoom => this == SignState.signed;
bool get haveRoom => this == SignState.unsigned;
bool get loading => this == SignState.loading;
}