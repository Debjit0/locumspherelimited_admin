import 'package:cloud_firestore/cloud_firestore.dart';
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
  String name = "";

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
              List participants = snapshot.data!.docs[index]["participants"];
              for (int i = 0; i < 2; i++) {
                if (participants[i] != "Admin") {
                  name = participants[i];
                }
              }

              return GestureDetector(
                onTap: () async {
                  String name = "";
                  List participants =
                      snapshot.data!.docs[index]["participants"];
                  for (int i = 0; i < 2; i++) {
                    if (participants[i] != "Admin") {
                      name = participants[i];
                    }
                  }
                  final splitted = name.split("_");
                  Get.to(ChatScreen(
                    name: splitted[0],
                    uid: splitted[1],
                  ));
                  //print("Admin_${name}}");
                  /*print(snapshot.data!.docs[index]["recentmessagesender"]
                  .toString()
                  .split("_")
                  .first);*/
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      name.substring(0, 1).toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  title: Text(
                    name.split("_").first,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Chat with ${name.split("_").first} Admin",
                    style: const TextStyle(fontSize: 13),
                  ),
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
                          uid: "sef",
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
