import 'package:flutter/material.dart';
import 'package:locumspherelimited_admin/Models/request_model.dart';

// ignore: must_be_immutable
class RequestDetails extends StatefulWidget {
  RequestDetails({super.key, required this.request});
  RequestModel request;
  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Details"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: Text("Allocate Employees"))
        ],
      ),
    );
  }
}
