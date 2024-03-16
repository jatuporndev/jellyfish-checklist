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
      var streamData = _getCollection().orderBy('update_at', descending: true).snapshots().map((snapshot) {
        return snapshot.docs.map((e) {
          Map<String, dynamic> data = e.data();
          return data['numberOfRamen'];
        });
      });
      return Right(streamData as Stream<int>);

    } catch(e) {
    return Left(Failure(500, e.toString()));
    }
  }

}