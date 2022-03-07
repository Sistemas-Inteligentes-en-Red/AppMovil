//import 'dart:convert';
import 'dart:convert';
import 'dart:io';

//import 'package:aplicacion1/pages/estado_page.dart';
//import 'package:aplicacion1/models/Novelty.dart';
//import 'package:aplicacion1/models/Novedad.dart';
import 'package:aplicacion1/pages/photo_page.dart';
import 'package:aplicacion1/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PointPage extends StatefulWidget {
  static const routeName = 'punto';

  final String ztoken;

  final int idc;
  final String direccion,
      cliente,
      nombre,
      telefono,
      tinicio,
      tfinal,
      hora,
      estado,
      nota;

  const PointPage(
      this.idc,
      this.direccion,
      this.cliente,
      this.nombre,
      this.telefono,
      this.tinicio,
      this.tfinal,
      this.hora,
      this.estado,
      this.nota,
      this.ztoken,
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
  var indicador = 'X';
  String texnovedad = "";

  @override
  Widget build(BuildContext context) {
    String estActualizado = 'Sin Actualizar';
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: IconButton(
              onPressed: () {
                _tomarFoto();
              },
              icon: Icon(Icons.camera_alt),
            ),
          ),
        ],
        title: Text('CLIENTE'),
        elevation: 12,
        backgroundColor: Color.fromRGBO(0, 48, 135, 1),
      ),
      body: AuthBacground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 120),
              CardContainer(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(0, 153, 255, 1), width: 1),
                          //borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButton(
                          //hint: Center(child: Text("Seleccione el Estado")),
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
                          value: valueChoose,
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
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: ("Ingrese Novedad"),
                        ),
                        onChanged: (texto) {
                          texnovedad = texto;
                        },
                        // autofocus: true,
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.orange,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          // hoverColor: Color.fromRGBO(254, 80, 0, 1),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Aceptar",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            estado = valueChoose;

                            // print(estado);

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
                            //print(estado);
                            //print(pk);
                            //print(widget.estado);

                            //llllllllllllllllllllllllllll
                            if (estActualizado == 'Sin Actualizar') {
                              setState(() {
                                estActualizado = 'Actualizado';
                              });
                            }

                            if (valueChoose == 'ninguno') {
                              setState(() {
                                indicador = 'Cambiar el Estado';
                              });
                              return null;
                            } else {
                              // print(pk);
                              // print(estado);
                              // print("Nota: " + texnovedad);

                              putData();
                            }

                            //lllllllllllll
                            setState(() {
                              _PointPageState();
                            });

                            //Navigator.maybePop(context);
                            //Navigator.pushNamed(context, 'puntos');
                            //Navigator.pop(context);
                          },
                          color: Color.fromRGBO(0, 153, 255, 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Estado:  " + estActualizado,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(0, 48, 135, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Text(
                      "CLIENTE:  " + widget.cliente,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(0, 48, 135, 1),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "CONTACTO:  " + widget.nombre,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "DIRECCION:  " + widget.direccion,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "TELEFONO:  " + widget.telefono,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Text("HORA:  " + widget.hora,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 15),

                    Text("Estado Actual:  " + widget.estado),

                    // newValue Text("Estado Actual:  " + widget.estado),
                    widget.nota == null || widget.nota == ""
                        ? Text("Novedad: Sin Novedad")
                        : Text("Novedad: " + widget.nota),

                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future putData() async {
    var response = await http.put(
        Uri.parse(
            "https://logistica-api.azurewebsites.net/api/update-novelty/" +
                widget.idc.toString() +
                "/"),
        headers: {
          HttpHeaders.authorizationHeader: "Token " + widget.ztoken
        },
        body: {
          //"novelty_pk": "2"
          "novelty_pk": pk.toString(),
          "note": texnovedad,
        });
    print(response.body);

    //print("XXXXXXXXXXX");
    //print(widget.ztoken);

    String npk, ntiempo, nnote;
    int nusername;

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      // print('Camilo');
      //print(jsonData);
      //print(response.statusCode);
      //print("------");

      npk = jsonData['novelty_m3_id'];
      nusername = jsonData['user_id'];
      ntiempo = jsonData['report_time'];
      nnote = jsonData['note_m3'];

      //print(npk);
      //print(nusername.toString());
      //print(ntiempo);
      //print(nnote);
    } else {
      print(response.statusCode);
      throw Exception("Fallo la Conexion");
    }
  }

  void _tomarFoto() {
    // Navigator.pushNamed(context, 'Photo');
    print("Tomar Foto");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PhotoPage(widget.ztoken, widget.idc)));
  }
}
