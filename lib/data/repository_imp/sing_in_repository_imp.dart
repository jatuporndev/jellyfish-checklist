import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:jellyfish/core/app/constrains.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/data/models/room_request.dart';
import 'package:jellyfish/domain/repository/sign_in_repository.dart';

import '../../core/app/app_prefs.dart';

class SignInRepositoryImp extends SignInRepository {
  final FirebaseFirestore firebaseFireStore;
  final AppPreferences _appPreferences;

  SignInRepositoryImp(this.firebaseFireStore, this._appPreferences);

  @override
  Future<Either<Failure, bool>> signIn(RoomRequest roomRequest) async {
    try {
      var collection = firebaseFireStore.collection(Constants.room);
      var docSnapshot = await collection.doc(roomRequest.key).get();
      Map<String, dynamic>? data = docSnapshot.data();
      if (data != null) {
        if (data["pin"] == roomRequest.pin) {
          await _appPreferences.setKey(roomRequest.key);
          return const Right(true);
        } else {
          return const Right(false);
        }
      } else {
        return const Right(false);
      }
    } catch (e) {
      return Left(Failure(500, "something wrong"));
    }
  }
}
