import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/ramen_count/get_ramen_use_case.dart';

part 'ramen_count_event.dart';
part 'ramen_count_state.dart';

class RamenCountBloc extends Bloc<RamenCountEvent,RamenCountState> {
  final GetRamenUseCase _getRamenUseCase;
  RamenCountBloc(this._getRamenUseCase): super(InitialState()) {
    on<GetRamen>(_getRamen);
  }


  Future<void> _getRamen(GetRamen event, Emitter<RamenCountState> emit) async {

  }
}


