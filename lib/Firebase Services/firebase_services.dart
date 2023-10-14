import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:locumspherelimited_admin/Models/request_model.dart';
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

//take request model as argument
//new collection to be made for allocations inside user
//add date[] to User.doc
//then in employee fetch list fetch employees without the date
//where("someArray", whereNotIn: ["someItem"])
  Future assignEmployees(
      List<SelectEmployee> selectedMale,
      List<SelectEmployee> selectedFemale,
      String reqId,
      RequestModel request) async {
    List emp = [];
    for (int i = 0; i < selectedMale.length; i++) {
      var uid = selectedMale[i].uid;
      emp.add(uid);
    }
    for (int i = 0; i < selectedFemale.length; i++) {
      var uid = selectedFemale[i].uid;
      emp.add(uid);
    }
    _firestore.collection("Requests").doc(reqId).update(
        {"assignedemployees": FieldValue.arrayUnion(emp), "isresponded": true});

    for (int i = 0; i < emp.length; i++) {
      _firestore
          .collection("Users")
          .doc(emp[i])
          .collection("Allocations")
          .doc("${emp[i]}_${reqId}")
          .set({
        "date": DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString(),
        "unitname": request.unitName,
        "unitid": request.unitid,
        "checkin":"",
        "checkout":"",
      });

      _firestore.collection("Attendance").doc(emp[i]).set({"${request.date}":""});

      //_firestore.collection("Users").doc(emp[i]).update({'allocateddates': FieldValue.arrayUnion([request.date])});
    }
  }
}
