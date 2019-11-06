import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_birder_x/models/user.dart';

class DatabaseService {
  final firestoreDB = Firestore.instance;

  Future<User> getUser(String id) {
    return firestoreDB
        .collection('users')
        .document(id)
        .get()
        .then((doc) => User.fromFirestore(doc));
  }

  Future<void> addBird(List data, String id) {
    return firestoreDB
        .collection('users')
        .document(id)
        .updateData({"seenBirds": FieldValue.arrayUnion(data)});
  }
}
