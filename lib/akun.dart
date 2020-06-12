import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './dbhelper.dart';
import './profilmodel.dart';
import 'package:sqflite/sqflite.dart';

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => new _AkunState();
}

class _AkunState extends State<Akun> {
  DbHelper dbHelper = DbHelper();
  List<Profil> profil;
  String keteranganProfil = '';

  @override
  void initState() {
    super.initState();
    _getProfil();
  }

  _getProfil() async {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Profil>> profilFuture = dbHelper.getProfil();
      profilFuture.then((profilList) {
        setState(() {
          profil = profilList;
          keteranganProfil = profil[0].nama + '\n';
          keteranganProfil += profil[0].alamat + '\n';
          keteranganProfil += profil[0].kota + '\n';
          keteranganProfil += profil[0].telp;
        });
      });
    });
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('slogin', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
      child: new Container(
          color: Colors.white,
          child: Center(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/profil.png'),
                      backgroundColor: Colors.grey,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15.0,
                                      right: 5.0,
                                      top: 15.0,
                                      bottom: 10.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(keteranganProfil,
                                            style: TextStyle(fontSize: 16)),
                                      ])),
                            ),
                          ),
                        ]),
                    Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          RaisedButton(
                            onPressed: _logOut,
                            color: Colors.white,
                            child: const Text('Logout',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ])),
                  ]),
            ),
          )),
    ));
  }
}
