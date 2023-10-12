import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

// ignore: must_be_immutable
class EmployeeDetails extends StatefulWidget {
  EmployeeDetails({super.key, required this.empName, required this.docId});
  String empName;
  String docId;
  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.empName)),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                
              },
              child: Text("View Attendance"))
        ],
      ),
    );
  }
}
