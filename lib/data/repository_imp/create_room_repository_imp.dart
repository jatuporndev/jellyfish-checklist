import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';

import '../../core/app/constrains.dart';
import '../../core/network/failure.dart';
import '../../domain/repository/create_room_repository.dart';
import '../models/room_request.dart';

class CreateRoomRepositoryImp extends CreateRoomRepository {
  final FirebaseFirestore firebaseFirestore;

  CreateRoomRepositoryImp(this.firebaseFirestore);

  @override
  Future<Either<Failure, bool>> createRoom(
      RoomRequest createRoomRequest) async {
    try {
      bool isExist = await _checkIfDocExists(createRoomRequest.key);
      if (isExist) {
        return Left(Failure(400, "alreadyRoom"));
      }

      var room =
          firebaseFirestore.collection("room").doc(createRoomRequest.key);
      room.set({"pin": createRoomRequest.pin});
      // room.collection("checklist").add({"title" : "test1"});
      // room.collection("achievement");
      return const Right(true);
    } catch (e) {
      return Left(Failure(500, "error"));
    }
  }

  Future<bool> _checkIfDocExists(String docId) async {
    try {
      var collectionRef = firebaseFirestore.collection(Constants.room);

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }
}
