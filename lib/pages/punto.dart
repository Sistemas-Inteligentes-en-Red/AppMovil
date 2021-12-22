//import 'package:aplicacion1/pages/puntos.dart';
//import 'dart:html';

import 'dart:io';
import 'package:aplicacion1/models/Novelty.dart';
import 'package:aplicacion1/pages/estado_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PointPage extends StatefulWidget {
  static const routeName = 'punto';
  final int idc;
  final String direccion,
      cliente,
      nombre,
      telefono,
      tinicio,
      tfinal,
      hora,
      estado;

  const PointPage(this.idc, this.direccion, this.cliente, this.nombre,
      this.telefono, this.tinicio, this.tfinal, this.hora, this.estado,
      {Key key})
      : super(key: key);

  @override
  _PointPageState createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  String valueChoose = 'Programada';
  String estado = 'ninguno';
  int pk = 0;
  List listItem = [
    "Programada",
    "En curso",
    "Próximo",
    "Con retraso",
    "Entregado",
    "Cancelado",
  ];
  var indicador = '.';
  //-----
  Future<List<Novelty>> _listadoNovelty;

  Future<List<Novelty>> _getNovelty() async {
    final response = await http.put(
        "https://logistica-api.azurewebsites.net/api/update-novelty/16/",
        headers: {
          HttpHeaders.authorizationHeader:
              "Token e686cf0c0ea85ebea25237c8db476d1b289512c0"
        },
        body: jsonEncode({
          {"novelty_pk": "5"}
        }));

    List<Novelty> novelty = [];

    if (response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      //print('Primera Impresion');
      //print(body);

      for (var item in jsonData["data"]) {
        novelty.add(Novelty(
          item["id"],
          item["clientAddress"],
        ));
      }
      return novelty;
    } else {
      print(response.statusCode);
      throw Exception("Fallo la Conexion");
    }
  }

  //-----
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATOS DEL CLIENTE'),
        elevation: 12,
        backgroundColor: Color.fromRGBO(0, 48, 135, 1),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black38,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  "images/avatar.png",
                  width: 110,
                  height: 110,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "CLIENTE:  " + widget.cliente,
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromRGBO(0, 153, 255, 1),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "CONTACTO:  " + widget.nombre,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "DIRECCION:  " + widget.direccion,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "TELEFONO:  " + widget.telefono,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text("HORA:  " + widget.hora,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 20),
                  //Text("Tiempo Inicial:  " + widget.tinicio),
                  //SizedBox(height: 10),
                  //Text("Tiempo Final:  " + widget.tfinal),
                  //SizedBox(height: 30),
                  Text("Estado Actual:  " + widget.estado),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(254, 80, 0, 1), width: 1),
                        //borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButton(
                        hint: Center(child: Text("Seleccione el Estado")),
                        dropdownColor: Colors.orange[50],
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 35,
                        isExpanded: true,
                        //underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        //----------value: valueChoose,
                        value: widget.estado,
                        onChanged: (newValue) {
                          setState(() {
                            valueChoose = newValue;
                          });
                        },
                        items: listItem.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Text(indicador),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Aceptar",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          estado = valueChoose;
                          print(estado);

                          setState(() {
                            if (estado == "Programada") {
                              estado = "Programada";
                            } else {
                              estado = valueChoose;
                            }
                            if (estado == "Programada") pk = 1;
                            if (estado == "En curso") pk = 2;
                            if (estado == "Próximo") pk = 3;
                            if (estado == "Con retraso") pk = 4;
                            if (estado == "Cancelado") pk = 5;
                            if (estado == "Entregado") pk = 6;
                          });
                          print(estado);
                          print(pk);
                          print(widget.estado);

                          if (valueChoose == 'ninguno') {
                            setState(() {
                              indicador = 'Cambiar el Estado';
                            });
                            return null;
                          } else {
                            print(pk);
                            print(estado);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EstadoPage()));
                          }
                        },
                        color: Color.fromRGBO(0, 153, 255, 1),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        //child: Text(estado),
                        child: Text(estado),
                      ),
                      Container(
                        child: Text("PK: " + pk.toString()),
                      ),
                      Container(
                        child: Text("ID: " + widget.idc.toString()),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
