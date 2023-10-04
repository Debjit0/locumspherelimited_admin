import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Services {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addUnit(
    String unitName,
    String location,
  ) async {
    final data = {
      'unitname': unitName,
      'location': location,
    };

    CollectionReference locationCollection = _firestore.collection("Units");
    try {
      await locationCollection.doc().set(data);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
