import 'package:either_dart/src/either.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/core/usecase/base_usecase.dart';
import 'package:jellyfish/domain/repository/check_list_repository.dart';

import '../../../data/models/check_list_result.dart';

class GetCheckListUseCase extends BaseUseCase<void, Stream<List<CheckListResult>>> {
  final CheckListRepository _checkListRepository;

  GetCheckListUseCase(this._checkListRepository);

  @override
  Future<Either<Failure, Stream<List<CheckListResult>>>> execute(void input) {
   return _checkListRepository.getCheckList();
  }

}