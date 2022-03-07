//import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:aplicacion1/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:location/location.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage(this.token, this.id, {Key key}) : super(key: key);
  // static const routeName = 'photo';

  final String token;
  final int id;
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  //eeee
  final chrono = Chronometer();
  //ee
  //gps
  Location location = new Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.granted;
  LocationData _locationData = LocationData.fromMap({});

  //gps

  File imagen;
  final picker = ImagePicker();

  Future selImagen(op) async {
    var pickedFile;

    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        // -----
        //imagen = File(pickedFile.path);
        cortar(File(pickedFile.path));
        // -----
      } else {}
    });
  }

  cortar(picked) async {
    File cortado = await ImageCropper.cropImage(
        sourcePath: picked.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));

    if (cortado != null) {
      setState(() {
        imagen = cortado;
      });
    }
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      selImagen(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Tomar Foto",
                                style: TextStyle(fontSize: 16)),
                          ),
                          Icon(Icons.camera_alt, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selImagen(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Seleccionar Foto",
                                style: TextStyle(fontSize: 16)),
                          ),
                          Icon(Icons.image, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),

                  //
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration:
                          BoxDecoration(color: Color.fromRGBO(254, 80, 0, 1)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Cancelar",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Icon(Icons.cancel, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro Fotografico"),
        backgroundColor: Color.fromRGBO(0, 48, 135, 1),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
// eeeee

                StreamBuilder<String>(
                  stream: chrono.chronometerStream,
                  initialData: '--:-- -- ----',
                  builder: (_, snapshot) {
                    return Text(snapshot.data);
                  },
                ),
                StreamBuilder<bool>(
                  stream: chrono.stateStream,
                  initialData: false,
                  builder: (_, snapshot) {
                    if (snapshot.data) {
                      return RaisedButton(
                          child: Text("Stop"), onPressed: chrono.stop);
                    } else {
                      return RaisedButton(
                          child: Text("Play"), onPressed: chrono.start);
                    }
                  },
                ),

//eeeeee
                SizedBox(
                  height: 10,
                ),
                Text('Longitud:'),
                Text(_locationData.latitude.toString()),
                SizedBox(
                  height: 10,
                ),
                Text('Latitud:'),
                Text(_locationData.longitude.toString()),
                SizedBox(
                  height: 10,
                ),
                Text(widget.token),
                SizedBox(
                  height: 10,
                ),
                Text(widget.id.toString()),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  onPressed: () {
                    getLocation();
                  },
                  child: Icon(Icons.location_on),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    opciones(context);
                  },
                  child: Text("Seleccione Imagen"),
                ),
                SizedBox(
                  height: 10,
                ),
                //Center(),
                imagen == null ? Center() : Image.file(imagen),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    subir_imagen1();
                  },
                  child: Text("Subir Imagen"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {});
  }

  Dio dio = new Dio();

  Future<void> subir_imagen1() async {
    print(imagen);
    try {
      String filename = imagen.path.split('/').last;
      print(filename);
      print(imagen?.path);
      FormData formData = new FormData.fromMap({
        //'usuario' : 'idusuario', puedo enviar mas datos
        'image': await MultipartFile.fromFile(imagen.path, filename: filename)
      });

      await dio
          .post(
              "https://logistica-api.azurewebsites.net/api/upload-image/" +
                  widget.id.toString() +
                  "/",
              options:
                  Options(headers: {'Authorization': "Token " + widget.token}),
              data: formData)
          .then((value) {
        print(value.toString());
        if (value.toString() == 'Cargada correctamente') {
          print('Carga Exitosa');
        } else {
          print('Error');
          print(value.toString());
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

//eeeeeeeeeeeeeeeeeeeeeeeeeeeeee
class Chronometer {
  //inicia el cromometro
  DateTime _startDateTime;
  final _mainStreamController = StreamController<String>();
  final _stateStreamController = StreamController<bool>();
  bool _running = false;

  Stream get chronometerStream {
    return _mainStreamController.stream;
  }

  Stream get stateStream {
    return _stateStreamController.stream;
  }

  bool get running {
    return _running;
  }

  void start() {
    _startDateTime = DateTime.now();
    _running = true;
    _stateStreamController.sink.add(true);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_running) {
        timer.cancel();
        return;
      }
      final diference = DateTime.now().difference(_startDateTime);
      String formato = formatDuration(diference);
      _mainStreamController.sink.add(formato);
    });
  }

  void stop() {
    _running = false;
    _stateStreamController.sink.add(false);
  }
}
  //eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
 