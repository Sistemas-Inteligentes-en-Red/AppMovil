import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key key}) : super(key: key);
  // static const routeName = 'photo';

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
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
        imagen = File(pickedFile.path);
      } else {}
    });
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
                    opciones(context);
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
}
