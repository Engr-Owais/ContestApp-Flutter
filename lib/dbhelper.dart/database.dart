import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contest_app/Model/Contest_Model.dart';
import 'package:contest_app/Model/participateusermodel.dart';
import 'package:contest_app/varibles.dart';

class DatabaseFire {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Variables vari =  Variables();
  // ignore: non_constant_identifier_names
  Future<void> addContent(ContestModel contestModel) async {
    // print(contestModel.imageUrl);
    print(contestModel.content);
    print(contestModel.description);
    await _firestore
        .collection("contests")
        .add(contestModel.toMap())
        .then((DocumentReference document) {
      // ignore: deprecated_member_use
      print(document.documentID);
    }).catchError((e) {
      print(e);
    });
  }

  Stream<List<ContestModel>> getUserList() {
    print("dat");

    return _firestore.collection('contests') .where("endDate",
            isGreaterThan: new DateTime.now().toUtc().millisecondsSinceEpoch).snapshots().map((snapShot) =>
        snapShot.docs
            .map((document) => ContestModel.fromJson(document.data()))
            .toList());
  }
    Stream<List<ContestModel>> getCompletedUserList() {
    return _firestore
        .collection('contests')
        .where("endDate",
            isLessThanOrEqualTo: new DateTime.now().toUtc().millisecondsSinceEpoch)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => ContestModel.fromJson({
                  "id": document.id,
                  "title": document.data()['title'],
                  "description": document.data()['description'],
                  "imageUrl": document.data()['imageUrl']
                }))
            .toList());
  }
Stream<List<UserContestModel>> getUsers() {
    return _firestore
        .collection('contests')
        .doc(vari.getContestID())
        .collection('users')
        .snapshots()
        .map((_snapShot) => _snapShot.docs
            .map((document) => UserContestModel.fromJson({
                  "id": document.id,
                  "username": document.data()['username'],
                  "email": document.data()['email'],
                  "votes":document.data()['votes'],
                  "imageUrlUser":document.data()['imageUrlUser']
                }))
            .toList());
  }

  
  Future<void> updateWinner(String contestId, String userId) async {
    await _firestore
        .collection('contests')
        .doc(contestId)
        .collection('users')
        .doc(userId)
        .update({'isWinner': true});
  }
}
