import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Universiteler extends StatefulWidget {
  @override
  _UniversitelerState createState() => _UniversitelerState();
}

class _UniversitelerState extends State<Universiteler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Universiteler"),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("universiteler").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Loading Data.. Please wait..");
          return ListView.builder(itemCount:snapshot.data.documents.length,itemBuilder: (context, int index) {
            return ListTile(
              leading: Icon(Icons.school),
              title: Text('${snapshot.data.documents[index]['isim']}\n '
                  'Minimum Toefl Puanı: ${snapshot.data.documents[index]['min_toefl']} \n'
                  'Minimum GPA Puanı: ${snapshot.data.documents[index]['min_gpa']} \n'
                  'Şehir: ${snapshot.data.documents[index]['sehir']}\n'),
              subtitle: Text('${snapshot.data.documents[index]['bolumler']}'),
            );
          });
        },
      ),
    );
  }
}
