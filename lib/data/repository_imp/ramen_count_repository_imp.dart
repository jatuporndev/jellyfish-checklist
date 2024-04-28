import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';

import 'package:jellyfish/core/network/failure.dart';

import '../../core/app/app_prefs.dart';
import '../../core/app/constrains.dart';
import '../../domain/repository/ramen_count_repository.dart';

class RamenRepositoryImp extends RamenCountRepository {
  final FirebaseFirestore _firebaseFirestore;
  final AppPreferences _appPreferences;

  RamenRepositoryImp(this._firebaseFirestore, this._appPreferences);

  CollectionReference<Map<String, dynamic>> _getCollection() {
    var key = _appPreferences.getKey();
    return _firebaseFirestore.collection(Constants.room).doc(key).collection(Constants.ramenCount);
  }

  @override
  Future<Either<Failure, Stream<int>>> getRamen() async {
    try {
      var streamData = _getCollection().doc(Constants.docRamen).snapshots().map((event) {
        if (event[Constants.numberOfRamen] == null) {
          throw Exception;
        }
        return event[Constants.numberOfRamen] as int;
      });
      return Right(streamData);

    } catch(e) {
    return Left(Failure(500, e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateRamen(int numberOfRamen) async {
    try {
      var request = {Constants.numberOfRamen: numberOfRamen};
      _getCollection().doc(Constants.docRamen).update(request);
      return const Right(true);
    } catch (e) {
      return Left(Failure(500, e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> initRamen() async {
    try {
      var ramenRef = _getCollection().doc(Constants.docRamen);
      ramenRef.get().then((docSnapshot) {
        if (docSnapshot.exists) {
          print('Room exists');
        } else {
          ramenRef.set({Constants.numberOfRamen: 0});
        }
      }).catchError((error) {
        print('Error checking room existence: $error');
      });
      return const Right(true);
    } catch (e) {
      return Left(Failure(500, e.toString()));
    }
  }

}