import 'package:cloud_firestore/cloud_firestore.dart';

class SelectEmployee {
  String firstname = "";
  String lastname = "";
  String uid = "";
  String gender = "";
  String email = "";
  String shiftPreference = "";
  bool isSelected = false;


  SelectEmployee(
      {required this.firstname,
      required this.lastname,
      required this.uid,
      required this.gender,
      required this.email,
      required this.shiftPreference,

      required this.isSelected});

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'uid': uid,
      'gender': gender,
      'email': email,
      'shiftPreference': shiftPreference,
    };
  }

  SelectEmployee.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.data()!['uid'],
        firstname = doc.data()!["firstname"],
        lastname = doc.data()!["lastname"],
        gender = doc.data()!["gender"],
        shiftPreference = doc.data()!["shiftpreference"],
        email = doc.data()!["email"];
}
