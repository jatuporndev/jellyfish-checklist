import 'package:either_dart/src/either.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/core/usecase/base_usecase.dart';
import 'package:jellyfish/data/models/room_request.dart';
import 'package:jellyfish/domain/repository/create_room_repository.dart';

class CreateRoomUseCase extends BaseUseCase<RoomRequest, bool> {
  final CreateRoomRepository _createRoomRepository;
  CreateRoomUseCase(this._createRoomRepository);

  @override
  Future<Either<Failure, bool>> execute(RoomRequest input) {
    return _createRoomRepository.createRoom(input);
  }

}