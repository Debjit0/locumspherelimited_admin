import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locumspherelimited_admin/Employee%20Screen/components/emp_tile2.dart';
import 'package:locumspherelimited_admin/Firebase%20Services/firebase_services.dart';
import 'package:locumspherelimited_admin/Models/request_model.dart';
import 'package:locumspherelimited_admin/Models/select_employee_model.dart';
import 'package:locumspherelimited_admin/Nav%20Bar/navbar.dart';

// ignore: must_be_immutable
class VerifySelection extends StatefulWidget {
  VerifySelection(
      {super.key,
      required this.request,
      required this.selectedFemale,
      required this.selectedMale,
      required this.reqId});
  List<SelectEmployee> selectedMale;
  List<SelectEmployee> selectedFemale;
  RequestModel request;
  String reqId;
  @override
  State<VerifySelection> createState() => _VerifySelectionState();
}

class _VerifySelectionState extends State<VerifySelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Selection"),
      ),
      body: Column(
        children: [
          Text(
            "Males Selected",
            style: TextStyle(fontSize: 20),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.selectedMale.length,
            itemBuilder: (context, index) {
              return EmpTile2Widget(
                title: widget.selectedMale[index].firstname,
                subtitle: widget.selectedMale[index].gender,
              );
            },
          ),
          Text(
            "Females Selected",
            style: TextStyle(fontSize: 20),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.selectedFemale.length,
            itemBuilder: (context, index) {
              return EmpTile2Widget(
                title: widget.selectedFemale[index].firstname,
                subtitle: widget.selectedFemale[index].gender,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Services()
              .assignEmployees(widget.selectedFemale, widget.selectedMale,
                  widget.reqId, widget.request)
              .whenComplete(() {
            Get.snackbar("Done", "Employees have been assigned");
            Get.to(NavBar());
          });
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
