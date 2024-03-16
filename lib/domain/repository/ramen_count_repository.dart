import 'package:either_dart/either.dart';

import '../../core/network/failure.dart';

abstract class RamenCountRepository {
  Future<Either<Failure, Stream<int>>> getRamen();
}