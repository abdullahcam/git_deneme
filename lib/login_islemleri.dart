import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginIslemleri extends StatefulWidget {
  @override
  _LoginIslemleriState createState() => _LoginIslemleriState();
}

class _LoginIslemleriState extends State<LoginIslemleri> {
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
              onPressed: aa,
            ),
          ],
        ),
      ),
    );
  }

  void aa() async {
    debugPrint("butona basıldı");

    String _email = "abdullahcam@gmail.com";
    String _password = "password";

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
