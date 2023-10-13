import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locumspherelimited_admin/Home%20Screen/components/request_tile.dart';
import 'package:locumspherelimited_admin/Models/request_model.dart';

class AllocationHistory extends StatefulWidget {
  const AllocationHistory({super.key});

  @override
  State<AllocationHistory> createState() => _AllocationHistoryState();
}

class _AllocationHistoryState extends State<AllocationHistory> {
  CollectionReference requestCollection =
      FirebaseFirestore.instance.collection('Requests');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allocation History"),
      ),
      body: StreamBuilder(
          stream: requestCollection
              .where("isresponded", isEqualTo: true)
              .snapshots(),
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
                    Get.to(
                      AllocationDetails(
                        reqId: snapshot.data!.docs[index].id,
                        request: RequestModel(
                            date: DateTime.parse(
                                    snapshot.data!.docs[index]['date'])
                                .toString(),
                            shiftPreference: snapshot.data!.docs[index]
                                ['shiftpreference'],
                            staffFemale: snapshot.data!.docs[index]
                                ['stafffemale'],
                            staffMale: snapshot.data!.docs[index]['staffmale'],
                            unitid: snapshot.data!.docs[index]['unitid'],
                            unitName: snapshot.data!.docs[index]['unitname']),
                        empAllocataed: snapshot.data!.docs[index]
                            ['assignedemployees'],
                      ),
                    );
                  },
                  child: RequestTileWidget(
                      date: DateTime.parse(snapshot.data!.docs[index]['date']),
                      shiftPreference: snapshot.data!.docs[index]
                          ['shiftpreference'],
                      staffFemale: snapshot.data!.docs[index]['stafffemale'],
                      staffMale: snapshot.data!.docs[index]['staffmale'],
                      unitid: snapshot.data!.docs[index]['unitid'],
                      unitName: snapshot.data!.docs[index]['unitname']),
                );
              },
            );
          }),
    );
  }
}

class AllocationDetailsModel {
  String fname;
  String lname;
  String gender;
  String phone;
  String shiftPreference;
  String reqId;
  String uid;
  String checkin;
  String checkout;

  AllocationDetailsModel(
      {required this.fname,
      required this.lname,
      required this.gender,
      required this.phone,
      required this.shiftPreference,
      required this.reqId,
      required this.uid,
      required this.checkin,
      required this.checkout});
}

// ignore: must_be_immutable
class AllocationDetails extends StatefulWidget {
  AllocationDetails(
      {super.key,
      required this.request,
      required this.empAllocataed,
      required this.reqId});
  String reqId;
  RequestModel request;
  List empAllocataed = [];
  @override
  State<AllocationDetails> createState() => _AllocationDetailsState();
}

class _AllocationDetailsState extends State<AllocationDetails> {
  List<AllocationDetailsModel> fetchedEmp = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAssignedEmployeesDetails().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? Scaffold(
            appBar: AppBar(title: Text("Allocation Details")),
            body: Column(
              children: [
                Text(widget.request.date),
                Text(widget.request.unitName),
                Text(widget.request.unitid),
                Text(widget.request.shiftPreference),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  itemCount: fetchedEmp.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(fetchedEmp[index].fname),
                        fetchedEmp[index].checkin!=""? Text(fetchedEmp[index].checkin):Text("--/--"),
                        fetchedEmp[index].checkout!=""? Text(fetchedEmp[index].checkout):Text("--/--")
                      ],
                    );
                  },
                ),
              ],
            ),
            )
        : Scaffold(
            body: Center(
            child: CircularProgressIndicator(),
          ));
  }

  Future getAssignedEmployeesDetails() async {
    for (int i = 0; i < widget.empAllocataed.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> snap1 = await FirebaseFirestore
          .instance
          .collection("Users")
          .doc(widget.empAllocataed[i])
          .get();

      DocumentSnapshot<Map<String, dynamic>> snap2 = await FirebaseFirestore
          .instance
          .collection("Users")
          .doc(widget.empAllocataed[i])
          .collection("Allocations")
          .doc('${snap1['uid']}_${widget.reqId}')
          .get();

      fetchedEmp.add(AllocationDetailsModel(
          fname: snap1['firstname'],
          lname: snap1['lastname'],
          gender: snap1['gender'],
          phone: snap1['phonenumber'],
          shiftPreference: snap1['shiftpreference'],
          reqId: widget.reqId,
          uid: snap1['uid'],
          checkin: snap2['checkin'],
          checkout: snap2['checkout']));
    }
  }
}
