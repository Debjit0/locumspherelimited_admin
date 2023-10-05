import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locumspherelimited_admin/Employee%20Screen/components/emp_tile2.dart';
import 'package:locumspherelimited_admin/Models/select_employee_model.dart';
import 'package:locumspherelimited_admin/Select%20Employees/components/select_emp_tile.dart';
import 'package:locumspherelimited_admin/utils/search_text_field.dart';

class SelectMale extends StatefulWidget {
  const SelectMale({super.key});

  @override
  State<SelectMale> createState() => _SelectMaleState();
}

class _SelectMaleState extends State<SelectMale> {
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
        .where('gender', isEqualTo: 'Male')
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
        .where('gender', isEqualTo: 'Male')
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
        title: Text("Select Male Employees"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.check)),
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
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : Icon(Icons.check_circle_outline),
                      onTap: () {
                        setState(() {
                          retrievedEmployeeList![index].isSelected =
                              !retrievedEmployeeList![index].isSelected;
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
      floatingActionButton: FloatingActionButton(
        onPressed: (() {}),
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
