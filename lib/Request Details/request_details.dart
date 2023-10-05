import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locumspherelimited_admin/Models/request_model.dart';
import 'package:locumspherelimited_admin/Models/select_employee_model.dart';
import 'package:locumspherelimited_admin/Select%20Employees/select_male.dart';

// ignore: must_be_immutable
class RequestDetails extends StatefulWidget {
  RequestDetails({super.key, required this.request});
  RequestModel request;
  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Details"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Get.to(SelectMale());
              },
              child: Text("Allocate Employees"))
        ],
      ),
    );
  }
}
