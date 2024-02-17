import 'package:either_dart/either.dart';

import '../../core/network/failure.dart';
import '../../data/models/room_request.dart';

abstract  class CreateRoomRepository {
  Future<Either<Failure, bool>> createRoom(RoomRequest createRoomRequest);
}