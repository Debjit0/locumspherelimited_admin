import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locumspherelimited_admin/Models/request_model.dart';
import 'package:locumspherelimited_admin/Models/select_employee_model.dart';
import 'package:locumspherelimited_admin/Select%20Employees/verify_selection.dart';

// ignore: must_be_immutable
class SelectFemale extends StatefulWidget {
  SelectFemale(
      {super.key,
      required this.reqId,
      required this.selectedMale,
      required this.request});
  List<SelectEmployee> selectedMale;
  RequestModel request;
  String reqId;
  @override
  State<SelectFemale> createState() => _SelectFemaleState();
}

class _SelectFemaleState extends State<SelectFemale> {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  //List<SelectEmployee> allResults= [];

  //List<DocumentSnapshot> documents = [];
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  List allResults = [];
  List resultList = [];
  late Future resultsLoaded;
  bool? checkboxvalue = false;
  Future<List<SelectEmployee>>? employeeList;
  List<SelectEmployee>? retrievedEmployeeList;
  List<SelectEmployee> selectedFemale = [];

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<List<SelectEmployee>> retrieveEmployees() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .where('isverified', isEqualTo: true)
        .where('accounttype', isEqualTo: 'employee')
        .where('gender', isEqualTo: 'Female')
        .get();
    return snapshot.docs
        .map((docSnapshot) => SelectEmployee.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<void> _initRetrieval() async {
    employeeList = retrieveEmployees();
    retrievedEmployeeList = await retrieveEmployees();
  }

  /*getEmployees() async {
    var empDocuments = await userCollection
        .where('isverified', isEqualTo: true)
        .where('accounttype', isEqualTo: 'employee')
        .where('gender', isEqualTo: 'Female')
        .get();

    setState(() {
      allResults = empDocuments.docs;
    });

    searchResults();
    return "done";
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Female Employees"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(VerifySelection(
                  request: widget.request,
                  reqId: widget.reqId,
                  selectedFemale: selectedFemale,
                  selectedMale: widget.selectedMale,
                ));
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: FutureBuilder(
        future: employeeList,
        builder: (BuildContext context,
            AsyncSnapshot<List<SelectEmployee>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: retrievedEmployeeList!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[50],
                        borderRadius: BorderRadius.circular(16.0)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      title: Text(retrievedEmployeeList![index].firstname),
                      subtitle: Text(retrievedEmployeeList![index].firstname),
                      trailing: retrievedEmployeeList![index].isSelected
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(Icons.check_circle_outline),
                      onTap: () {
                        setState(() {
                          retrievedEmployeeList![index].isSelected =
                              !retrievedEmployeeList![index].isSelected;

                          if (retrievedEmployeeList![index].isSelected ==
                              true) {
                            selectedFemale.add(SelectEmployee(
                                firstname:
                                    retrievedEmployeeList![index].firstname,
                                lastname:
                                    retrievedEmployeeList![index].lastname,
                                uid: retrievedEmployeeList![index].uid,
                                gender: retrievedEmployeeList![index].gender,
                                email: retrievedEmployeeList![index].email,
                                shiftPreference: retrievedEmployeeList![index]
                                    .shiftPreference,
                                isSelected:
                                    retrievedEmployeeList![index].isSelected));
                            //print(selectedFemale.length);
                          } else if (retrievedEmployeeList![index].isSelected ==
                              false) {
                            selectedFemale.removeWhere((element) =>
                                element.firstname ==
                                retrievedEmployeeList![index].firstname);
                                print(selectedFemale.length);
                          }
                        });
                      },
                    ),
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.done &&
              retrievedEmployeeList!.isEmpty) {
            return Center(
              child: ListView(
                children: const <Widget>[
                  Align(
                      alignment: AlignmentDirectional.center,
                      child: Text('No data available')),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
