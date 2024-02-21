import 'package:either_dart/src/either.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/core/usecase/base_usecase.dart';
import 'package:jellyfish/data/models/check_list_result.dart';

import '../../repository/check_list_repository.dart';

class UpdateCheckListUseCase extends BaseUseCase<CheckListResult, bool>{
  final CheckListRepository _checkListRepository;
  UpdateCheckListUseCase(this._checkListRepository);

  @override
  Future<Either<Failure, bool>> execute(CheckListResult input) {
    return _checkListRepository.updateCheckList(input);
  }

}