
import 'package:flutter/material.dart';


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
