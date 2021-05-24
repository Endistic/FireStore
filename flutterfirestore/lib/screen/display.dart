import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayScreen extends StatefulWidget {
  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ข้อมูลบันทึกราคาเหรียญ")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Text(document["price"] + " " + "บาท"),
                    ),
                  ),
                  title: Text(document["pname"]),
                  subtitle: Text(document["comp"]),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
