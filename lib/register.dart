import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

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
  TextEditingController _dogumGunuController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _dogumGunuController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _dogumGunuController.dispose();
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
                    decoration: InputDecoration(
                      hintText: "şifre giriniz..",
                      labelText: "sifre",
                    ),
                  ),
                ),
                Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(fontSize: 25),
                ),
                RaisedButton(
                  onPressed: () => _selectDate(context), // Refer step 3
                  child: Text(
                    'Doğum Tarihinizi Seçiniz',
                    style: TextStyle(
                        color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text(
                        "Oluştur",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      onPressed: kullaniciyiOlustur,
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

  void kullaniciyiOlustur() async {
    if (_formKey.currentState.validate()) {
      _email = _emailController.text;
      _password = _passwordController.text;
      _dogumGunu = _dogumGunuController.text;
      debugPrint("kullanıcı kaydedildi : " + _emailController.text.toString());

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

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 1900,
              maximumYear: 2025,
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Doğum Tarihinizi Seçiniz',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Doğum Tarihiniz',
      fieldHintText: 'Ay/Gün/Yıl',

      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
/* _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      helpText: 'Doğum Tarihinizi Seçiniz',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to dark theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  */
