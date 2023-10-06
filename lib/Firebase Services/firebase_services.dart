import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:locumspherelimited_admin/Models/select_employee_model.dart';

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

  Future assignEmployees(List<SelectEmployee> selectedMale,
      List<SelectEmployee> selectedFemale, String reqId) async {
    List emp = [];
    for (int i = 0; i < selectedMale.length; i++) {
      var uid = selectedMale[i].uid;
      emp.add(uid);
    }
    for (int i = 0; i < selectedFemale.length; i++) {
      var uid = selectedFemale[i].uid;
      emp.add(uid);
    }
    _firestore
        .collection("Requests")
        .doc(reqId)
        .update({"assignedemployees": FieldValue.arrayUnion(emp),"isresponded":true});
  }
}
