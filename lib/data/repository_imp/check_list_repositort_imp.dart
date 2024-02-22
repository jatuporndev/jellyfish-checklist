import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:jellyfish/core/app/constrains.dart';
import 'package:jellyfish/core/network/failure.dart';
import 'package:jellyfish/data/models/check_list_result.dart';
import 'package:jellyfish/data/models/count_data.dart';
import 'package:jellyfish/domain/repository/check_list_repository.dart';

import '../../core/app/app_prefs.dart';

class CheckListRepositoryImp extends CheckListRepository {
  final FirebaseFirestore _firebaseFirestore;
  final AppPreferences _appPreferences;

  CheckListRepositoryImp(this._firebaseFirestore, this._appPreferences);

  CollectionReference<Map<String, dynamic>> _getCollection() {
    var key = _appPreferences.getKey();
    return _firebaseFirestore.collection(Constants.room).doc(key).collection(Constants.checkList);
  }

  @override
  Future<Either<Failure, Stream<List<CheckListResult>>>> getCheckList() async {
    try {
      var streamData = _getCollection().orderBy('update_at', descending: true).snapshots().map((snapshot) {
        return snapshot.docs.map((e) {
          Map<String, dynamic> data = e.data();
          return CheckListResult.fromMap(data, e.id);
        }).toList();
      });
      return Right(streamData);
    } catch (e) {
      return Left(Failure(500, e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addCheckList(CheckListResult checkListResult) async {
    try {
      await _getCollection().add(checkListResult.toJson());
      return const Right(true);
    } catch (e) {
      return Left(Failure(500, e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateCheckList(CheckListResult checkListResult) async {
    Map<Object, Object> request = {};
    var isCheck = checkListResult.isCheck;
    var title = checkListResult.title;
    if (isCheck != null) {
      request = {'isCheck': isCheck};
    }
    if (title != null) {
      request = {'title': title};
    }
    try {
      _getCollection().doc(checkListResult.id).update(request);
      return const Right(true);
    } catch (e) {
      return Left(Failure(500, e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCheckList(CheckListResult checkListResult) async {
    try {
      await _getCollection().doc(checkListResult.id).delete();
      return const Right(true);
    } catch (e) {
      return Left(Failure(500, e.toString()));
    }
  }

  @override
  Future<Either<Failure, CountData>> countCheckList() async {
    try {
      var collection = _getCollection();
      var dataTotalSnapshot = await collection.get();
      var dataTotal = dataTotalSnapshot.size;

      var dataCountSnapshot = await collection.where('isCheck', isEqualTo: true).get();
      var dataCount = dataCountSnapshot.size;

      return Right(CountData(count: dataCount, total: dataTotal));
    } catch (e) {
      return Left(Failure(500, e.toString()));
    }
  }
}
