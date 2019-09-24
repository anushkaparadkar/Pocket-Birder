import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String id;
  String name;
  String email;
  List<Map> seenBirds;

  User({
    this.id,
    this.name,
    this.email,
    this.seenBirds,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return User(
      id: doc.documentID,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      seenBirds: List.from(data['seenBirds']) ?? [],
    );
  }

  String getName() => this.name;
  String getID() => this.id;
  String getEmail() => this.email;
  List<Map> getSeenBirds() => this.seenBirds;

  setName(String name) => this.name = name;
}
