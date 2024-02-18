import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:jellyfish/core/app/constrains.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/data/models/check_list_result.dart';
import 'package:jellyfish/domain/repository/check_list_repository.dart';

import '../../core/app/app_prefs.dart';

class CheckListRepositoryImp extends CheckListRepository {
  final FirebaseFirestore _firebaseFirestore;
  final AppPreferences _appPreferences;

  CheckListRepositoryImp(this._firebaseFirestore, this._appPreferences);

  CollectionReference<Map<String, dynamic>> _getCollection() {
    var key = _appPreferences.getKey();
    return _firebaseFirestore
        .collection(Constants.room)
        .doc(key)
        .collection(Constants.checkList);
  }

  @override
  Future<Either<Failure, Stream<List<CheckListResult>>>> getCheckList() async {
    var streamData = _getCollection().snapshots().map((snapshot) {
      return snapshot.docs.map((e) {
        Map<String, dynamic> data = e.data();
        return CheckListResult.fromMap(data, e.id);
      }).toList();
    });

    return Right(streamData);
  }
}
