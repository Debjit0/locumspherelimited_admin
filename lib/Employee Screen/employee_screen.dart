import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:locumspherelimited_admin/Employee%20Screen/components/emp_tile2.dart';
import 'package:locumspherelimited_admin/Verifty%20Employees/components/emp_tile.dart';
import 'package:locumspherelimited_admin/Verifty%20Employees/verify_employees.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
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
              icon: Icon(Icons.check))
        ],
      ),
      body: StreamBuilder(
          stream: userCollection
              .where('isverified', isEqualTo: true)
              .where('accounttype', isEqualTo: 'employee')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }

            
            

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                print(snapshot.data!.docs.length);
                return GestureDetector(
                  onTap: () {},
                  child: EmpTile2Widget(title: snapshot.data!.docs[index]['firstname'], subtitle: snapshot.data!.docs[index]['gender']),
                );
              },
            );
          }),
    );
  }

  changeToTrue({@required String? id}) async {
    print(id);
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .update({"isverified": true}).then((value) => Get.snackbar("Verified", "Employee verified successfully"));
      print("trued");
    } catch (e) {
      print(e);
    }
  }

  changeToFalse({@required String? id}) async {
    print(id);
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .update({"isverified": false});
      print("falsed");
    } catch (e) {
      print(e);
    }
  }
}
