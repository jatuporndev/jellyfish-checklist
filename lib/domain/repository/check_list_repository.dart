import 'package:either_dart/either.dart';
import 'package:jellyfish/data/models/check_list_result.dart';

import '../../core/network/failure.dart';

abstract class CheckListRepository {
  Future<Either<Failure, Stream<List<CheckListResult>>>> getCheckList();
  Future<Either<Failure, bool>> updateCheckList(CheckListResult checkListResult);
  Future<Either<Failure, bool>> addCheckList(CheckListResult checkListResult);
}