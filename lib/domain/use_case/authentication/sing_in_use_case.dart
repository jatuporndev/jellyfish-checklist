import 'package:either_dart/src/either.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/core/usecase/base_usecase.dart';
import 'package:jellyfish/data/models/room_request.dart';
import 'package:jellyfish/domain/repository/sign_in_repository.dart';

class SignInUseCase extends BaseUseCase<RoomRequest, bool> {
  final SignInRepository _signInRepository;
  SignInUseCase(this._signInRepository);

  @override
  Future<Either<Failure, bool>> execute(RoomRequest input) {
    return _signInRepository.signIn(input);
  }

}