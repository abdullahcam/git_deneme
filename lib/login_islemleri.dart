import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginIslemleri extends StatefulWidget {


  @override
  _LoginIslemleriState createState() => _LoginIslemleriState();
}

class _LoginIslemleriState extends State<LoginIslemleri> {
  String _email;
  String _password;
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
        title: Text("Login Islemleri"),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text("Kullanıcı olustur"),
              onPressed: manuelKullaniciEkleme,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "email giriniz..",
                        labelText: "Email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "şifre giriniz..",
                        labelText: "sifre",
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text("Kaydet"),
                    onPressed: kullaniciyiVeritabaninaKaydet,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void manuelKullaniciEkleme() async {
    debugPrint("butona basıldı");

    String _email1 = "abdullahcam@gmail.com";
    String _password1 = "password";

    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: _email1, password: _password1);
      User _yeniUser = _credential.user;
      debugPrint(_yeniUser.toString());
    } catch (e) {
      debugPrint("***************hata var ****************************");
      debugPrint(e.toString());
    }
  }

  void kullaniciyiVeritabaninaKaydet() async {
    debugPrint("kullanıcı kaydedildi : " + _emailController.text.toString());

    _email = _emailController.text;
    _password = _passwordController.text;

    debugPrint(_email);
    debugPrint(_password);

    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      User _yeniUser = _credential.user;
      debugPrint(_yeniUser.toString());
    } catch (e) {
      debugPrint("***************hata var ****************************");
      debugPrint(e.toString());
    }
  }
}
