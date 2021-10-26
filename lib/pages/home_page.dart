import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeNme = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
      ),
      body: Center(
        child: Text("plataforma Ruteo"),
      ),
    );
  }
}
