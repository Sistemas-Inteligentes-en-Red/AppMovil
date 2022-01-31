//import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
//import 'package:aplicacion1/models/Novelty.dart';
import 'package:flutter/material.dart';

class EstadoPage extends StatefulWidget {
  const EstadoPage({Key key}) : super(key: key);

  @override
  _EstadoPageState createState() => _EstadoPageState();
}

class _EstadoPageState extends State<EstadoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estado'),
      ),
      body: Center(
        child: Text('Pagina de Estado'),
      ),
    );
  }

  putData() async {
    var response = await http.put(
        Uri.parse(
            "https://logistica-api.azurewebsites.net/api/update-novelty/15/"),
        headers: {
          HttpHeaders.authorizationHeader:
              //"Content-Type": "application/json",
              //"Accept": "application/json, text/plain",
              "Token e686cf0c0ea85ebea25237c8db476d1b289512c0"
        },
        body: {
          "novelty_pk": "1"
        });
    print(response.body);
  }

  @override
  void initState() {
    super.initState();
    putData();
  }
}
