import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locumspherelimited_admin/Home%20Screen/components/request_tile.dart';
import 'package:locumspherelimited_admin/Models/request_model.dart';
import 'package:locumspherelimited_admin/Request%20Details/request_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  List allResults = [];
  List resultList = [];
  CollectionReference requestCollection =
      FirebaseFirestore.instance.collection('Requests');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Requests"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined))
        ],
      ),
      body: StreamBuilder(
          stream: requestCollection.where("isresponded", isEqualTo: false).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Get.to(RequestDetails(
                        reqId: snapshot.data!.docs[index].id,
                        request: RequestModel(
                          date: snapshot.data!.docs[index]['date'],
                          staffFemale: snapshot.data!.docs[index]
                              ['stafffemale'],
                          staffMale: snapshot.data!.docs[index]['staffmale'],
                          unitName: snapshot.data!.docs[index]['unitname'],
                          unitid: snapshot.data!.docs[index]['unitid'],
                          shiftPreference: snapshot.data!.docs[index]
                              ['shiftpreference'],
                        ),
                      ));
                    },
                    child: RequestTileWidget(
                        date:
                            DateTime.parse(snapshot.data!.docs[index]['date']),
                        shiftPreference: snapshot.data!.docs[index]
                            ['shiftpreference'],
                        staffFemale: snapshot.data!.docs[index]['stafffemale'],
                        staffMale: snapshot.data!.docs[index]['staffmale'],
                        unitid: snapshot.data!.docs[index]['unitid'],
                        unitName: snapshot.data!.docs[index]['unitname']),);
              },
            );
          }),
    );
  }
}
