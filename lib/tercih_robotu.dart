import "package:flutter/material.dart";
import 'package:git_deneme/universiteler.dart';


class TercihRobotu extends StatefulWidget {
  @override
  _TercihRobotuState createState() => _TercihRobotuState();
}

class _TercihRobotuState extends State<TercihRobotu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tercih Robotu"),),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "TOEFL",
                      labelText: "TOEFL puaninizi giriniz",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "GPA",
                      labelText: "GPA giriniz",
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      child: Text(
                        "Universiteleri Gor",
                        style: TextStyle(fontSize: 10),
                      ),
                      onPressed: () {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Universiteler()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
