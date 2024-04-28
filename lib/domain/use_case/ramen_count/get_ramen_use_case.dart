import 'package:either_dart/src/either.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/domain/repository/ramen_count_repository.dart';

import '../../../core/usecase/base_usecase.dart';

class GetRamenUseCase extends BaseUseCase<void, Stream<int>> {
  final RamenCountRepository _ramenCountRepository;

  GetRamenUseCase(this._ramenCountRepository);

  @override
  Future<Either<Failure, Stream<int>>> execute(void input) {
    return _ramenCountRepository.getRamen();
  }
}
