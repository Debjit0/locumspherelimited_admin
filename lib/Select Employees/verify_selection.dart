import 'package:flutter/material.dart';
import 'package:locumspherelimited_admin/Models/select_employee_model.dart';

// ignore: must_be_immutable
class VerifySelection extends StatefulWidget {
  VerifySelection({super.key, required this.selectedFemale, required this.selectedMale});
  List<SelectEmployee> selectedMale;
  List<SelectEmployee> selectedFemale;
  @override
  State<VerifySelection> createState() => _VerifySelectionState();
}

class _VerifySelectionState extends State<VerifySelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}