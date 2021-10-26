import 'dart:convert';
//import 'dart:io';

import 'package:aplicacion1/models/Gif.dart';
//import 'package:aplicacion1/widgets/circle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaPage extends StatefulWidget {
  static const routeName = 'rutas';
  ListaPage({Key key}) : super(key: key);

  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  // ignore: unused_field
  Future<List<Gif>> _listadoGifs;
  // ignore: missing_return

  Future<List<Gif>> _getGifs() async {
    final response = await http.post(
        Uri.encodeFull("http://10.0.2.2:8000/api/report-milla/"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json, text/plain",
          //'Authorization': 'Token 15da269baf2777bf3590919ca146b860cb022e3c'
          'Authorization': 'Token 3ea5587ab6663f6cc240106c154651d27ed14d3d'
        },
        body: jsonEncode({
          "data": {"date": "", "vehicle": "SNL943", "user": ""}
        }));

    //creamos lista
    List<Gif> gifs = [];
    //
    if (response.statusCode == 201) {
      //print(response.body);
      //Esto es para que las api este codificada
      String body = utf8.decode(response.bodyBytes);
      //convertimos la informacion en un json valido
      // ignore: unused_local_variable
      final jsonData = jsonDecode(body);
      //print(jsonData["data"][0]);
      //---------------------------------------------------
      print('Este es el Token');
      print(jsonData);

      //----------------------------------------------------
      var notesJson = json.decode(response.body);
      for (var item in notesJson) {
        gifs.add(Gif(item["id"], item["route"], item["total_distance"],
            item["total_time"], item["date"]));
      }
      //print(gifs.toString());
      return gifs;
    } else {
      print(response.statusCode);
      throw Exception("Fallo la ConexionXX");
    }
  }

  @override
  void initState() {
    super.initState();
    _listadoGifs = _getGifs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rutas'),
          elevation: 12,
          backgroundColor: Color.fromRGBO(0, 48, 135, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          //actions: [
          //IconButton(
          // icon: Icon(Icons.access_alarms),
          //onPressed: () {
          // print("XXX");
          // _showPuntos(context);
          //}),
          //],
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

  List<Widget> _listGifs(List<Gif> data) {
    List<Widget> gifs = [];
    for (var gif in data) {
      gifs.add(Card(
        child: ListTile(
          leading: Icon(
            Icons.airport_shuttle,
            color: Color.fromRGBO(254, 80, 0, 1),
          ),
          title: Column(
            children: [
              Text("Ruta: " + gif.id.toString()),
              Text(gif.ruta),
              Text(" "),
            ],
          ),
          isThreeLine: true,
          subtitle: Column(
            children: [
              Text("Fecha: " + gif.fecha),
              Text("Tiempo: " + gif.tiempo.toString()),
              Text("Distancia: " + gif.distancia.toString()),
            ],
          ),
          onTap: () {
            _showPuntos(context);
            //print("**********************************");
            // print(gif.id);
            //print(gif.ruta);
            //print(gif.tiempo.toString());
            // print(gif.distancia.toString());
            //print(gif.fecha);
            //print(gifs);
          },
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Color.fromRGBO(254, 80, 0, 1),
          ),
          //Column(
          //children: [
          //Card(
          //child: Column(
          // children: [
          // Text("T: " + gif.tiempo.toString()),
          //Text(gif.tiempo.toString()),
          //Text("D: " + gif.distancia.toString()),
          //Text(gif.distancia.toString()),
          // ],
          // ),
          //),
          // ],
          //),
          minLeadingWidth: 20,
          //minVerticalPadding: 10,
          //selected: true,
          selectedTileColor: Colors.white24,
        ),
      ));
    }
    return gifs;
  }

  void _showPuntos(BuildContext context) {
    //Navigator.pushNamed(context, 'rutas');
    //Navigator.pushNamed(context, ListaPage.routeName);
    Navigator.pushNamed(context, 'puntos');
  }
}
