import 'package:flutter/material.dart';
import 'package:locumspherelimited_admin/constants/colors.dart';

// ignore: must_be_immutable
class SearchTextField extends StatelessWidget {
  SearchTextField({
    required this.hintText,
    required this.controller,
    super.key,
  });

  TextEditingController controller = TextEditingController();
  String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.black,
          //fontSize: 14,
        ),

        controller: controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          prefixIconColor: primaryColor,
          prefixIcon: Icon(Icons.search),
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}