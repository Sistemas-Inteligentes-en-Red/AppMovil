import 'package:aplicacion1/models/Gifx.dart';
import 'package:flutter/material.dart';

class PointPage extends StatelessWidget {
  //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
  static const routeName = 'punto';
  //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
  //const PointPage({Key key}) : super(key: key);
  final Gifx gif;

  const PointPage({Key key, this.gif}) : super(key: key);
  //PointPage(this.gif);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATOS DEL PUNTO'),
        elevation: 12,
        backgroundColor: Color.fromRGBO(0, 48, 135, 1),
      ),
      body: Text("xcv"),
    );
  }
}
