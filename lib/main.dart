import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Github Deneme",
      home: AppBar(title: Text("Github deneme"),),
    );
  }
}
