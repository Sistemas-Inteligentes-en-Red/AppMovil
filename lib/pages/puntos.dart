import 'dart:convert';
import 'dart:io';
import 'package:aplicacion1/models/Gifx.dart';
import 'package:aplicacion1/models/Mapaz.dart';
import 'package:aplicacion1/pages/punto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:logger/logger.dart';

class PuntosRuta extends StatefulWidget {
  static const routeName = 'puntos';

  final String xtoken;
  final int idx;
  PuntosRuta(this.idx, this.xtoken, {Key key}) : super(key: key);
  @override
  _PuntosRutaState createState() => _PuntosRutaState();
}

class _PuntosRutaState extends State<PuntosRuta> {
  final formKey = new GlobalKey<ScaffoldState>();
  int idc;
  String direccion;
  String cliente;
  String nombre;
  String telefono;
  String tinicio;
  String tfinal;
  String hora;
  //--
  String estado;
  //--

  String pasarDato;
  Future<List<Gifx>> _listadoGifs;

  Future<List<Gifx>> _getGifs() async {
    final response = await http.get(
        "https://logistica-api.azurewebsites.net/api/results-detail-milla/" +
            widget.idx.toString() +
            "/",
        headers: {HttpHeaders.authorizationHeader: "Token " + widget.xtoken});

    List<Gifx> gifs = [];

    if (response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      //print('Primera Impresion');
      //print(body);

      for (var item in jsonData["data"]) {
        gifs.add(Gifx(
            item["id"],
            item["clientAddress"],
            item["clientName"],
            item["contact_name"],
            item["contactPhone"],
            item["time_window_start"],
            item["time_window_end"],
            item["hours"],
            //--
            item["novelty"]
            //--
            ));
      }
      return gifs;
    } else {
      print(response.statusCode);
      throw Exception("Fallo la Conexion");
    }
  }

  // ignore: unused_field
  Future<String> _listadoGifsxx;
  var fred;
  Future<String> _getGifsxx([String pasarDato]) async {
    final response = await http.get(
        "https://logistica-api.azurewebsites.net/api/results-detail-milla/" +
            widget.idx.toString() +
            "/",
        headers: {HttpHeaders.authorizationHeader: "Token " + widget.xtoken});

    if (response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      String pasarDato = jsonData['map'];

      final mapas = new Mapas(pasarDato);

      //print('Segunda Impresion');
      //print(
      //"https://logistica-api.azurewebsites.net/api/results-detail-milla/" +
      // widget.idx.toString() +
      //  "/");
      //print(mapas.pasar);

      fred = mapas.pasar;

      return mapas.pasar;
    } else {
      print(response.statusCode);
      throw Exception("Fallo la ConexionXX");
    }
  }

  @override
  void initState() {
    super.initState();
    _listadoGifs = _getGifs();
    _listadoGifsxx = _getGifsxx();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text("CLIENTES - RUTA: " + widget.idx.toString()),
          elevation: 12,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Card(
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      "images/iconmapa.png",
                    ),
                    iconSize: 40,
                    onPressed: () => _showRuta(context),
                  ),
                  Text(
                    "",
                  ),
                ],
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: _listadoGifs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _listGifs(snapshot.data),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("ErrorX");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _listGifs(List<Gifx> data) {
    List<Widget> gifs = [];
    for (var gif in data) {
      gifs.add(
        //--

        //--
        Card(
          child: ListTile(
              leading: Icon(
                Icons.person,
                color: Color.fromRGBO(0, 153, 255, 1),
              ),
              trailing: Card(
                //--
                //color: gif.estado == 'Entregado'
                // ? Colors.green
                // : Colors.amberAccent,
                color: gif.estado == 'Entregado'
                    ? Color(0xFF91C5A4)
                    : gif.estado == 'Con retraso'
                        ? Color(0xFFDECCA5)
                        : gif.estado == 'Cancelado'
                            ? Color(0xFFC96969)
                            : gif.estado == 'En curso'
                                ? Color(0xFFB1C7D6)
                                : gif.estado == 'Próximo'
                                    ? Color(0xFFEBAC87)
                                    : Color(0xFFD9D8D5),
                //--
                //color: Color(0xC20969),
                child: Column(
                  children: [
                    Text(
                      "Hora",
                      style: TextStyle(
                        //fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      gif.hora,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Text(
                    // gif.estado,
                    //style: TextStyle(
                    //fontSize: 15,
                    //color: Colors.black,
                    //),
                    //),
                  ],
                ),
              ),
              title: Center(
                child: Column(
                  children: [
                    Text(gif.cliente,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              subtitle: Center(
                child: Column(
                  children: [
                    Text(
                      "Dir: " + gif.direccion,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      gif.estado,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                idc = gif.id;
                direccion = gif.direccion;
                cliente = gif.cliente;
                nombre = gif.nombre;
                telefono = gif.telefono;
                tinicio = gif.tinicio;
                tfinal = gif.tfinal;
                hora = gif.hora;
                //----
                estado = gif.estado;
                //-----
                //print(idc);
                // print(direccion);
                //print(cliente);
                //print(nombre);
                //print(telefono);
                //print(tinicio);
                //print(tfinal);
                //print(hora);
                //*print(_textoController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PointPage(idc, direccion, cliente,
                            nombre, telefono, tinicio, tfinal, hora, estado)));

                _showPunto(context);
              }),
        ),
      );
    }
    return gifs;
  }

  void _showRuta(BuildContext context) async {
    var ooo = await _getGifsxx(pasarDato);
    Navigator.of(context).pushNamed("/second", arguments: ooo.toString());
    //print("**********************************");
    //print(_getGifsxx.toString());
    //print(Mapas(pasarDato));
    //print(ooo);
  }

  void _showPunto(BuildContext context) {
    Navigator.pushNamed(context, 'Punto');
    //Navigator.push(context,
    // MaterialPageRoute(builder: (context) => PuntosRuta(idc, estado)));
  }
}
