import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectEmpTile extends StatelessWidget {
  SelectEmpTile({
    required this.title,
    required this.subtitle,
    super.key,
  });

  TextEditingController controller = TextEditingController();
  String title;
  String subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:14,vertical: 7),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.deepPurple[50], borderRadius: BorderRadius.circular(20)),
      child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle)),
    );
  }
}