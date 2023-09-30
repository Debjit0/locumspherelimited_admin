import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:locumspherelimited_admin/Verifty%20Employees/components/emp_tile.dart';

class VerifyEmployees extends StatefulWidget {
  const VerifyEmployees({super.key});

  @override
  State<VerifyEmployees> createState() => _VerifyEmployeesState();
}

class _VerifyEmployeesState extends State<VerifyEmployees> {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Employees"),
      ),
      body: StreamBuilder(
          stream: userCollection
              .where('isverified', isEqualTo: false)
              .where('accounttype', isEqualTo: 'employee')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                print(snapshot.data!.docs.length);
                return GestureDetector(
                    onTap: () {},
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text("Are you sure?"),
                                content: Text("Update verification status"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                    onPressed: () {
                                      if (snapshot.data!.docs[index]
                                              ['isverified'] ==
                                          true) {
                                        changeToFalse(
                                          id: snapshot.data!.docs[index].id,
                                        );
                                        Navigator.pop(context);
                                        setState(() {});
                                      } else {
                                        changeToTrue(
                                          id: snapshot.data!.docs[index].id,
                                        );
                                        Navigator.pop(context);
                                        setState(() {});
                                      }
                                    },
                                    child: Text("ok"),
                                  )
                                ],
                              ));
                    },
                    child: EmpTileWidget(
                        title: snapshot.data!.docs[index]['firstname'],
                        subtitle: "Longpress to verity"));
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
          .update({"isverified": true}).then((value) =>
              Get.snackbar("Verified", "Employee verified successfully"));
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
