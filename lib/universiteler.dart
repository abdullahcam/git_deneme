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
      appBar: AppBar(title: Text("Universiteler"),),
      body:(ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.school_rounded),
              title: Text("Bogazici"),
            );
          }
      )

      )
      );
  }
}

class GetUserGpaAndToefl extends StatelessWidget {
  final String documentId;

  GetUserGpaAndToefl(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference universiteler = FirebaseFirestore.instance.collection(
        'universiteler');

    return FutureBuilder<DocumentSnapshot>(
      future: universiteler.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text(
              "Gpa: ${data['min_gpa']} " + "TOEFL: ${data['min_toefl']}");
        }
        void toString(){
          print("Gpa: ${['min_gpa']} " + "TOEFL: ${['min_toefl']}");
        }

        return Text("loading");
      },
    );
  }
}
