import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jellyfish/domain/use_case/ramen_count/init_ramen_use_case.dart';
import 'package:jellyfish/domain/use_case/ramen_count/update_ramen_use_case.dart';

import '../../../domain/use_case/ramen_count/get_ramen_use_case.dart';

part 'ramen_count_event.dart';

part 'ramen_count_state.dart';

class RamenCountBloc extends Bloc<RamenCountEvent, RamenCountState> {
  final GetRamenUseCase _getRamenUseCase;
  final UpdateRamenUseCase _updateRamenUseCase;
  final InitRamenUseCase _initRamenUseCase;

  RamenCountBloc(this._getRamenUseCase, this._updateRamenUseCase, this._initRamenUseCase) : super(LoadingState()) {
    on<GetRamen>(_getRamen);
    on<UpdateRamen>(_updateRamen);
    on<InitRamen>(_initRamen);
  }

  Future<void> _getRamen(GetRamen event, Emitter<RamenCountState> emit) async {
    emit(LoadingState());
    var result = await _getRamenUseCase.execute(null);
    result.fold((left) => {emit(ErrorState("Fail"))}, (right) => {emit(DataLoadedState(right))});
  }

  Future<void> _initRamen(InitRamen event, Emitter<RamenCountState> emit) async {
    var result = await _initRamenUseCase.execute(null);

  }

  Future<void> _updateRamen(UpdateRamen event, Emitter<RamenCountState> emit) async {
    var numberOfRamen = event.numberOfRamen;
    if (numberOfRamen == null) {
      emit(ErrorState("Fail"));
      return;
    }

    if (event.isIncrease) {
      numberOfRamen += 1;
    } else {
      if (numberOfRamen < 1) {
        return;
      }
      numberOfRamen -= 1;
    }
    await _updateRamenUseCase.execute(numberOfRamen);
  }


}
