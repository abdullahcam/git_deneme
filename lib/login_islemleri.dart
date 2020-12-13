import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:git_deneme/register.dart';
import 'package:git_deneme/tercih_robotu.dart';

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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login Islemleri"),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      child: Text(
                        "Hesabın Yok mu? Hemen Oluştur!",
                        style: TextStyle(fontSize: 10),
                      ),
                      onPressed: () {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterSayfasi()));
                      },
                    ),
                    RaisedButton(
                      child: Text("Giriş Yap"),
                      onPressed: girisYap,
                    ),
                    RaisedButton(
                      child: Text("Çıkış Yap"),
                      onPressed: cikisYap,
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

  Future<TercihRobotu> girisYap() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    try {
      if (_auth.currentUser == null) {
        User oturumAcanUser = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;

        debugPrint(
            "kullanıcı : " + _auth.currentUser.toString() + "giriş yaptı");
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => TercihRobotu()));
      } else {
        debugPrint(
            "Oturum açmış kullanıcı zaten var ya da yanlış kullanıcı bilgisi");
      }
    } catch (e) {
      debugPrint("hata : " + e.toString());
    }
  }

  void cikisYap() async {
    final snackBar = SnackBar(
      content: Text("zaten oturum açmış kullanıcı yok"),
    );

    if (_auth.currentUser != null) {
      _auth.signOut();
      debugPrint("oturum açan kullanıcı : " +
          _auth.currentUser.toString() +
          "çıkış yaptı");
    } else {
      _scaffoldKey.currentState.showSnackBar(snackBar);
      debugPrint("zaten oturum açmış kullanıcı yok");
    }
  }
}
