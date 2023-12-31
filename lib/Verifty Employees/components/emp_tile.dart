import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmpTileWidget extends StatelessWidget {
  EmpTileWidget({
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
      margin: const EdgeInsets.symmetric(horizontal:14,vertical: 7),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.deepPurple[50], borderRadius: BorderRadius.circular(20)),
      child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle)),
    );
  }
}
