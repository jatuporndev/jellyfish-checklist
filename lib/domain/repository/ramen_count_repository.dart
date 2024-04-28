import 'package:either_dart/either.dart';
import 'package:jellyfish/presentation/ramen_count/bloc/ramen_count_bloc.dart';

import '../../core/network/failure.dart';

abstract class RamenCountRepository {
  Future<Either<Failure, Stream<int>>> getRamen();
  Future<Either<Failure, bool>> updateRamen(int numberOfRamen);
  Future<Either<Failure, bool>> initRamen();
}