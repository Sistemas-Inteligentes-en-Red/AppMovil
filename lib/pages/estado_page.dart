import 'package:flutter/material.dart';

class EstadoPage extends StatelessWidget {
  const EstadoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estado'),
      ),
      body: Center(
        child: Text('Pagin de Estado'),
      ),
    );
  }
}
