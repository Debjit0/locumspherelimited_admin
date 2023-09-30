import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:locumspherelimited_admin/Add%20Units/components/textformfieldwidget.dart';
import 'package:locumspherelimited_admin/Firebase%20Services/firebase_services.dart';
import 'package:locumspherelimited_admin/Nav%20Bar/navbar.dart';


class AddUnits extends StatefulWidget {
  const AddUnits({super.key});

  @override
  State<AddUnits> createState() => _AddUnitsState();
}

class _AddUnitsState extends State<AddUnits> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController unitNameController = TextEditingController();

  TextEditingController unitLocationController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Units")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset("assets/images/login.png"),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormFieldWidget(
                            hintText: 'Enter your unit name',
                            controller: unitNameController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormFieldWidget(
                            hintText: 'Enter unit location',
                            controller: unitLocationController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 50,
                          child: FilledButton.tonal(
                              onPressed: () async {
                                //print(shiftPreference);
                                if (unitNameController.text == '' ||
                                    unitLocationController.text == '') {
                                  Get.snackbar(
                                      "Error", "Please fill all the fields");
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Services()
                                      .addUnit(unitNameController.text,
                                          unitLocationController.text)
                                      .then((value) {
                                    Get.snackbar("Added", "Unit Added");
                                    Get.offAll(() => NavBar());
                                  });
                                }
                              },
                              child: isLoading == false
                                  ? Text("Add")
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
