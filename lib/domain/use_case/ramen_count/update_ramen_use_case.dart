import 'package:either_dart/src/either.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/core/usecase/base_usecase.dart';

import '../../repository/ramen_count_repository.dart';

class UpdateRamenUseCase  extends BaseUseCase<int, bool>{
  final RamenCountRepository _ramenCountRepository;
  UpdateRamenUseCase(this._ramenCountRepository);

  @override
  Future<Either<Failure, bool>> execute(int input) {
    return _ramenCountRepository.updateRamen(input);
  }
  
}