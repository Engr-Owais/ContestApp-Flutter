import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contest_app/Model/Contest_Model.dart';

class DatabaseFire {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  Future<void> addContent(ContestModel contestModel) async {
    print(contestModel.imageUrl);
    _firestore
        .collection("contests")
        .add(contestModel.toMap())
        .then((DocumentReference document) {
      // ignore: deprecated_member_use
      print(document.documentID);
    }).catchError((e) {
      print(e);
    });
  }
}
