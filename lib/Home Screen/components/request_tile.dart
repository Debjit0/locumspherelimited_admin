import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class RequestTileWidget extends StatelessWidget {
  RequestTileWidget({
    required this.date,
    required this.shiftPreference,
    required this.staffMale,
    required this.staffFemale,
    required this.unitid,
    required this.unitName,
    super.key,
  });

  TextEditingController controller = TextEditingController();
  DateTime date;
  String shiftPreference;
  String staffMale;
  String staffFemale;
  String unitid;
  String unitName;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.deepPurple[50],
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Date Requested : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(DateFormat.yMMMEd().format(date)),
              ],
            ),
            Row(
              children: [
                Text(
                  "Shift : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(shiftPreference),
              ],
            ),
            Row(
              children: [
                Text(
                  "Male Requirements : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(staffMale),
              ],
            ),
            Row(
              children: [
                Text(
                  "Female Requirements : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(staffFemale),
              ],
            ),
            Row(
              children: [
                Text(
                  "Requested By : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(unitName),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Container(
            //       color: Colors.green,
            //       child: GestureDetector(
            //         onTap: (){},
            //         child: Row(children: [
            //           Icon(Icons.check),
            //           Text("Accept")
            //         ],),
            //       ),
            //     ),
            //     Container(
            //       color: Colors.red,
            //       child: GestureDetector(
            //         onTap: (){},
            //         child: Row(children: [
            //           Icon(Icons.close),
            //           Text("Reject")
            //         ],),
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Text("View Details"),
            //     )
            //   ],
            // ),
          ],
        ));
  }
}
