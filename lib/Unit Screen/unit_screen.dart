
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:locumspherelimited_admin/Add%20Units/add_units.dart';
import 'package:locumspherelimited_admin/Unit%20Screen/components/unit_tile.dart';


class UnitsScreen extends StatefulWidget {
  const UnitsScreen({super.key});

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  CollectionReference unitCollection =
      FirebaseFirestore.instance.collection('Units');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Units")),
      body: StreamBuilder(
          stream: unitCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }

            
            

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                print(snapshot.data!.docs.length);
                return GestureDetector(
                  onTap: () {},
                  child: UnitTile(title: snapshot.data!.docs[index]['unitname'], subtitle: snapshot.data!.docs[index]['location']),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddUnits());
        },
        child: Icon(Icons.add),
        elevation: 0,
      ),
    );
  }
}
