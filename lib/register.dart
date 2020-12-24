import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:date_field/date_field.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegisterSayfasi extends StatefulWidget {
  @override
  _RegisterSayfasiState createState() => _RegisterSayfasiState();
}

class _RegisterSayfasiState extends State<RegisterSayfasi> {
  String _email;
  String _password;
  String _dogumGunu;
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Islemleri"),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _emailController,
                    showCursor: true,
                    enableSuggestions: true,
                    maxLines:1,
                    keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "email giriniz..",
                      labelText: "Email",
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.length < 5) {
                        return "karakter sayısı 5'ten fazla olmalı";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _passwordController,
                      showCursor: true,
                      enableSuggestions: true,
                      maxLines:1,
                      keyboardType:TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "şifre giriniz..",
                      labelText: "sifre",
                    ),
                      validator: (girilenDeger) {
                        if (girilenDeger.length < 5) {
                          return "sifre en az 6 karakter olmali";
                        } else {
                          return null;
                        }
                      }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: DateTimeField(
                    selectedDate: selectedDate,
                    onDateSelected: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    lastDate: DateTime(2021),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            child: Text(
              "Oluştur",
            ),
            onPressed: kullaniciyiOlustur,
          ),
        ],
      ),
    );
  }

  void kullaniciyiOlustur() async {
    if (_formKey.currentState.validate()) {
      _email = _emailController.text;
      _password = _passwordController.text;
      _dogumGunu = selectedDate.toLocal().toString().split(" ")[0];

      try {
        UserCredential _credential = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        User _yeniUser = _credential.user;

        debugPrint(_yeniUser.toString());

        Map<String, dynamic> dbyeEklenenKullanici = Map();
        dbyeEklenenKullanici["sifre"] = [_password];
        dbyeEklenenKullanici["dogum_gunu"] = [_dogumGunu];

        _firestore
            .collection("users")
            .doc(_email)
            .set(dbyeEklenenKullanici)
            .then((value) => debugPrint("firestore'a kullanıcı eklendi"))
            .catchError((hata) => debugPrint("hata: $hata"));
        return Navigator.pop(context);
      } catch (e) {
        debugPrint("***************hata var ****************************");
        debugPrint(e.toString());
      }
    } else {
      debugPrint("validator'da sıkıntı var");
    }
  }
}
