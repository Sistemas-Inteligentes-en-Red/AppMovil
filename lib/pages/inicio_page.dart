//import 'package:aplicacion1/pages/rutas_page.dart';
//import 'dart:io';

import 'package:aplicacion1/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InicioPage extends StatefulWidget {
  static const routeName = 'inicio';
  InicioPage({Key key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final _scaffkey = GlobalKey<ScaffoldState>();

  final formKey = new GlobalKey<ScaffoldState>();
  String placa;

  @override
  Widget build(BuildContext context) {
    //------------------------------------------------------
    SecondPageArguments arguments = ModalRoute.of(context).settings.arguments;
    //----------------------------------------------------
    return Scaffold(
      key: _scaffkey,
      appBar: AppBar(
        title: Text('Inicio Conductores'),
        elevation: 12,
        backgroundColor: Color.fromRGBO(0, 48, 135, 1),
        //actions: [
        // IconButton(
        // icon: Icon(Icons.logout, color: Colors.red),
        // onPressed: () {
        //exit(0);
        //   SystemNavigator.pop();
        //  })
        //],
      ),
      drawer: _getDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              height: 200,
              width: 150,
            ),
            Text(
              //-------------------------------------------------
              'Bienvenido Plataforma Ruteo: ' + arguments.username,

              //---------------------------------------------------
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10),
            Text(
              //-------------------------------------------------
              'Buscar Rutas por Placa',

              //---------------------------------------------------
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: InputText(
                  keyboardType: TextInputType.emailAddress,
                  label: "INGRESAR PLCA DEL VEHICULO"),
            ),
            SizedBox(height: 20),
            Container(
              child: SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Consultar Ruta",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => _showRuta(context),
                  color: Color.fromRGBO(0, 153, 255, 1),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton(
      // child: Icon(Icons.menu),
      //  onPressed: () => _scaffkey.currentState.openDrawer(),
      //  backgroundColor: Color.fromRGBO(254, 80, 0, 1),
      //),
    );
  }

  Widget _getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Sistemas Inteligentes en Red'),
            accountEmail: Text('Plataforma Ruteo'),
            //currentAccountPicture: FlutterLogo(),
            currentAccountPicture: Image.asset(
              "images/logo.png",
              color: Colors.white,
            ),
            onDetailsPressed: () {},
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(0, 48, 135, 1),
                Color.fromRGBO(0, 85, 140, 1),
              ]),
            ),
          ),
          Card(
            child: ListTile(
              title: InputText(
                  keyboardType: TextInputType.emailAddress,
                  label: "PLACA DEL VEHICULO",
                  //nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
                  onChanged: (value) {
                    placa = value;
                  },
                  validator: (valor) {
                    if (valor.trim().length == 0) {
                      return "Ingresa la Placa";
                    }
                    return null;
                  }
                  //nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
                  ),
              leading: Icon(
                Icons.airport_shuttle,
                color: Color.fromRGBO(0, 153, 255, 1),
              ),
              trailing: Icon(Icons.arrow_forward,
                  color: Color.fromRGBO(0, 153, 255, 1)),
              onTap: () => _showRuta(context),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Reportes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Colors.black12,
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Indicadores',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: Icon(
                Icons.contact_mail_sharp,
                color: Colors.black12,
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Cerrar Seccion',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: Color.fromRGBO(254, 80, 0, 1),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showRuta(BuildContext context) {
    //Navigator.pushNamed(context, 'rutas');
    //Navigator.pushNamed(context, ListaPage.routeName);
    Navigator.pushNamed(context, 'rutas');
  }
}

//------------------------------------------------------
class SecondPageArguments {
  String token;
  String username;
  SecondPageArguments(this.token, this.username);
}
//--------------------------------------------------------
