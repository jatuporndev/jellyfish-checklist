import 'package:either_dart/src/either.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/core/usecase/base_usecase.dart';
import 'package:jellyfish/data/models/count_data.dart';

import '../../repository/check_list_repository.dart';

class CountCheckListUseCase extends BaseUseCase<void, CountData> {
  final CheckListRepository _checkListRepository;
  CountCheckListUseCase(this._checkListRepository);

  @override
  Future<Either<Failure, CountData>> execute(void input) {
    return _checkListRepository.countCheckList();
  }

}