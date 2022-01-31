import 'dart:convert';
import 'package:aplicacion1/models/Gif.dart';
import 'package:aplicacion1/pages/puntos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaPage extends StatefulWidget {
  static const routeName = 'rutas';

  final String placa, xtoken;

  ListaPage(this.placa, this.xtoken, {Key key}) : super(key: key);

  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final formKey = new GlobalKey<ScaffoldState>();
  int idx;

  String xtoken;

  Future<List<Gif>> _listadoGifs;

  Future<List<Gif>> _getGifs() async {
    final response = await http.post(
        Uri.parse("https://logistica-api.azurewebsites.net/api/report-milla/"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json, text/plain",
          'Authorization': 'Token ' + widget.xtoken
        },
        body: jsonEncode({
          "data": {"date": "", "vehicle": widget.placa.toString(), "user": ""}
        }));

    List<Gif> gifs = [];
    //
    if (response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);
      // ignore: unused_local_variable
      final jsonData = jsonDecode(body);
      var notesJson = json.decode(response.body);
      for (var item in notesJson) {
        gifs.add(Gif(item["id"], item["route"], item["total_distance"],
            item["total_time"], item["date"], item["total_visits"]));
      }
      return gifs;
    } else {
      //print(response.statusCode);
      throw Exception("Fallo la Conexion");
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
          title: Text('RUTAS - ' + widget.placa),
          elevation: 12,
          backgroundColor: Color.fromRGBO(0, 48, 135, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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

  List<Widget> _listGifs(List<Gif> data) {
    List<Widget> gifs = [];
    for (var gif in data) {
      gifs.add(Card(
        child: ListTile(
          leading: Icon(
            Icons.airport_shuttle,
            color: Color.fromRGBO(0, 48, 135, 1),
          ),
          title: Column(
            children: [
              Text(
                "FECHA: " + gif.fecha,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Visitas: " + gif.visit.toString(),
                style: TextStyle(),
              ),
            ],
          ),
          subtitle: Column(
            children: [],
          ),
          onTap: () {
            idx = gif.id;
            xtoken = widget.xtoken;
            //print(idx);
            //print(xtoken);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PuntosRuta(idx, xtoken)));
          },
          trailing: Card(
            child: Column(
              children: [
                Text(
                  "Ruta: " + gif.id.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 153, 255, 1),
                  ),
                ),
                Text("t(m): " + gif.tiempo.toString()),
                Text("d(km): " + gif.distancia.toString()),
              ],
            ),
            color: Colors.grey[50],
          ),
        ),
      ));
    }
    return gifs;
  }
}
