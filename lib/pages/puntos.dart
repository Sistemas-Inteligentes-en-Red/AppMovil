import 'dart:convert';
//import 'dart:html';
import 'dart:io';

//import 'package:aplicacion1/models/Gif.dart';
import 'package:aplicacion1/models/Gifx.dart';
import 'package:aplicacion1/models/Mapaz.dart';
//import 'package:aplicacion1/pages/punto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PuntosRuta extends StatefulWidget {
  static const routeName = 'puntos';
  PuntosRuta({Key key}) : super(key: key);
  @override
  _PuntosRutaState createState() => _PuntosRutaState();
}

class _PuntosRutaState extends State<PuntosRuta> {
  String pasarDato;
  // ignore: unused_field
  Future<List<Gifx>> _listadoGifs;

  // ignore: missing_return
  Future<List<Gifx>> _getGifs() async {
    final response = await http
        .get("http://10.0.2.2:8000/api/results-detail-milla/10/", headers: {
      HttpHeaders.authorizationHeader:
          "Token 3ea5587ab6663f6cc240106c154651d27ed14d3d"
    });

    List<Gifx> gifs = [];

    if (response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      //String pasarDato1 = jsonDecode(body);

      print('Primera Impresion');
      print(body);

      for (var item in jsonData["data"]) {
        gifs.add(Gifx(
            item["id"],
            item["clientAddress"],
            item["clientName"],
            item["contact_name"],
            item["contactPhone"],
            item["time_window_start"],
            item["time_window_end"]));
      }
      return gifs;
    } else {
      print(response.statusCode);
      throw Exception("Fallo la ConexionXX");
    }
  }

  // ignore: unused_field
  Future<String> _listadoGifsxx;
  var fred;
  // ignore: missing_return
  //Future<String> _getGifsxx([String pasarDato]) async {
  Future<String> _getGifsxx([String pasarDato]) async {
    final response = await http
        .get("http://10.0.2.2:8000/api/results-detail-milla/10/", headers: {
      HttpHeaders.authorizationHeader:
          "Token 3ea5587ab6663f6cc240106c154651d27ed14d3d"
    });

    //creamos lista
    //String fred = '';
    //
    if (response.statusCode == 201) {
      //print(response.body);

      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      String pasarDato = jsonData['map'];

      final mapas = new Mapas(pasarDato);

      print('Segunda Impresion');
      print(mapas.pasar);

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
          title: Text('PUNTOS                   Mapa ->'),
          elevation: 12,
          backgroundColor: Color.fromRGBO(0, 48, 135, 1),
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
                    icon: Icon(
                      Icons.add_road,
                      color: Color.fromRGBO(254, 80, 0, 1),
                    ),
                    onPressed: () => _showRuta(context),
                  ),
                  Text(
                    "",
                    style: TextStyle(color: Colors.orange),
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
              //print(snapshot.data);
              //return Text("HolaX");
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
      gifs.add(Card(
        child: ListTile(
            leading: Icon(
              Icons.add_location_alt,
              color: Colors.blue,
            ),
            trailing: Card(
              child: Column(
                children: [
                  Text("Inicio: " + gif.tinicio),
                  Text("Final: " + gif.tfinal),
                ],
              ),
            ),
            title: Text("Cliente: " + gif.cliente),
            subtitle: Column(
              children: [
                Text("Dir: " + gif.direccion),
                Text("Telefono: " + gif.telefono),
              ],
            ),
            onTap: () {
              //mmmmmmmmmmmmmmmmmmmmmmmmmmm
              print(gif.id.toString());
              print(gif.direccion);
              print(gif.cliente);
              print(gif.nombre);
              print(gif.telefono);
              print(gif.tinicio);
              print(gif.tfinal);
              _showPunto(context);
              //mmmmmmmmmmmmmmmmmmmmmm
            }),
      ));
    }
    return gifs;
  }

  void _showRuta(BuildContext context) async {
    var ooo = await _getGifsxx(pasarDato);
    Navigator.of(context).pushNamed("/second", arguments: ooo.toString());
    print("**********************************");
    print(_getGifsxx.toString());
    print(Mapas(pasarDato));
    print(ooo);
  }

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
  //void _showPunto(BuildContext context) async {
  //var aaa = await _getGifs();
  //Navigator.of(context).pushNamed("/punto", arguments: aaa.toString());
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
  void _showPunto(BuildContext context) {
    Navigator.pushNamed(context, 'punto');
  }
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
}
