import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:locumspherelimited_admin/Employee%20Details%20Page/employee_details.dart';
import 'package:locumspherelimited_admin/Employee%20Screen/components/emp_tile2.dart';
import 'package:locumspherelimited_admin/Verifty%20Employees/verify_employees.dart';
import 'package:locumspherelimited_admin/constants/colors.dart';
import 'package:locumspherelimited_admin/utils/search_text_field.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  //List<DocumentSnapshot> documents = [];
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  List allResults = [];
  List resultList = [];
  late Future resultsLoaded;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    searchResults();
  }

  searchResults() {
    var showResults = [];
    if (searchController.text != "") {
      for (var emp in allResults) {
        var name = emp['firstname'].toString().toLowerCase();
        if (name.contains(searchController.text.toLowerCase())) {
          showResults.add(emp);
        }
      }
    } else {
      showResults = List.from(allResults);
    }

    setState(() {
      resultList = showResults;
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getEmployees();
  }

  getEmployees() async {
    var empDocuments = await userCollection
        .where('isverified', isEqualTo: true)
        .where('accounttype', isEqualTo: 'employee')
        .get();

    setState(() {
      allResults = empDocuments.docs;
    });

    searchResults();
    return "done";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employees"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(VerifyEmployees());
              },
              icon: Icon(Icons.check, color: primaryColor,)),
        ],
      ),
      body: Column(
        children: [
          SearchTextField(
            hintText: "Search",
            controller: searchController,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: resultList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(EmployeeDetails(
                        empName: resultList[index]['firstname'],
                        docId: resultList[index]['uid']));
                  },
                  child: EmpTile2Widget(
                      title: resultList[index]['firstname'],
                      subtitle: resultList[index]['gender']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
