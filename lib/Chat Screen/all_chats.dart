import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:locumspherelimited_admin/Chat%20Screen/chat_screen.dart';

class AllChat extends StatefulWidget {
  const AllChat({super.key});

  @override
  State<AllChat> createState() => _AllChatState();
}

class _AllChatState extends State<AllChat> {
  CollectionReference ChatCollection =
      FirebaseFirestore.instance.collection('Chats');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Chats"),
      ),
      body: StreamBuilder(
        stream: ChatCollection.where("participants", arrayContains: "Admin")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (snapshot.data!.docs.length == 0) {
            return Text("No Data");
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  String name = "";
                  List participants =
                      await snapshot.data!.docs[index]["participants"];
                  for (int i = 0; i < 2; i++) {
                    if (participants[i] != "Admin") {
                      name = participants[i];
                    }
                  }
                  Get.to(ChatScreen(name: name));
                  print("Admin_${name}}");
                },
                child: Container(
                  margin: EdgeInsets.all(14),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.lightGreen),
                  child: Text(snapshot.data!.docs[index]['recentmessage']),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Wrap(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Admin"),
                      onTap: () {
                        Get.to(ChatScreen(
                          name: "Admin",
                        ));
                      },
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
        elevation: 0,
      ),
    );
  }
}
