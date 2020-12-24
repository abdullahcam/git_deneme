import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:git_deneme/universiteler.dart';


class TercihRobotu extends StatefulWidget {
  @override

  _TercihRobotuState createState() => _TercihRobotuState();
}

class _TercihRobotuState extends State<TercihRobotu> {
  static double _toefl;
  static double _gpa;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _toeflController;
  TextEditingController _gpaController;


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _toeflController = TextEditingController();
    _gpaController = TextEditingController();
  }

  @override
  void dispose() {
    _toeflController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tercih Robotu"),),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _toeflController,
                    showCursor: true,
                    enableSuggestions: true,
                    maxLines:1,
                    keyboardType:TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "TOEFL",
                      labelText: "TOEFL puaninizi giriniz",
                    ),
                    validator: (girilenDeger) {
                      double input = double.parse(girilenDeger);
                      if (input > 100 && input < 0 ) {
                        return "0 ile 100 arasinda bir sayi girmeniz gerekmektedir.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "GPA",
                      labelText: "GPA giriniz",
                    ),
                    validator: (girilenDeger) {
                      double input = double.parse(girilenDeger);
                      if (input > 4 && input < 0 ) {
                        return "0 ile 4 arasinda bir sayi girmeniz gerekmektedir.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide()),
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

  Future<TercihRobotu> universiteleriListele() async {
     _toefl= _toeflController as double;
    _gpa = _gpaController as double;
  }

  static double get gpa => _gpa;
  static double get toefl => _toefl;

  TextEditingController get toeflController => _toeflController;

  TextEditingController get gpaController => _gpaController;
}

