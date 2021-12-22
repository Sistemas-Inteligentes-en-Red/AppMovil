import 'package:aplicacion1/pages/rutas_page.dart';
//import 'package:aplicacion1/widgets/input_text.dart';
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
  String placa, xtoken;
  final placaVehiculo = TextEditingController();
  var textox = 'Palaca del vehiculo';
  @override
  Widget build(BuildContext context) {
    SecondPageArguments arguments = ModalRoute.of(context).settings.arguments;
    TextEditingController _textoController = TextEditingController(text: "");
    return Scaffold(
      key: _scaffkey,
      appBar: AppBar(
          title: Text('CONDUCTORES'),
          elevation: 12,
          backgroundColor: Colors.black),
      drawer: _getDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              height: 180,
              width: 130,
            ),
            Text(
              'Bienvenido: ' + arguments.token,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.text,
                controller: _textoController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.car_rental),
                  fillColor: Colors.blue[30],
                  filled: true,
                  hintText: "Placa",
                  helperText: textox,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Consultar Ruta",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_textoController.text.trim().length == 0) {
                      setState(() {
                        textox = 'Por Favor Ingrese la Placa del Vehiculo';
                      });
                      return null;
                    } else {
                      xtoken = arguments.username;
                      print(_textoController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ListaPage(_textoController.text, xtoken)));
                    }
                  },
                  color: Color.fromRGBO(0, 153, 255, 1),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
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
          //Card(
          //child: ListTile(
          //title: InputText(
          //keyboardType: TextInputType.emailAddress,
          //label: "Rutas",
          //onChanged: (value) {
          //placa = value;
          //},
          //validator: (valor) {
          //if (valor.trim().length == 0) {
          //return "Ingresa la Placa";
          //}
          //return null;
          //}),
          //leading: Icon(
          //Icons.airport_shuttle,
          //color: Color.fromRGBO(0, 153, 255, 1),
          //),
          //trailing: Icon(Icons.arrow_forward,
          //  color: Color.fromRGBO(0, 153, 255, 1)),
          //onTap: () => _showRuta(context),
          //),
          //),
          //Card(
          //child: ListTile(
          //title: Text(
          //'Reportes',
          //style: TextStyle(
          //fontSize: 16,
          //fontWeight: FontWeight.w500,
          //),
          //),
          //leading: Icon(
          //Icons.home,
          //color: Colors.black12,
          //),
          //onTap: () {},
          //),
          //),
          //Card(
          //child: ListTile(
          //title: Text(
          //'Indicadores',
          //style: TextStyle(
          //fontSize: 16,
          //fontWeight: FontWeight.w500,
          //),
          //),
          //leading: Icon(
          //Icons.contact_mail_sharp,
          //color: Colors.black12,
          //),
          //onTap: () {},
          //),
          //),
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

  //void _showRuta(BuildContext context) {
  //Navigator.pushNamed(context, 'rutas');
  //}
}

class SecondPageArguments {
  String token;
  String username;
  SecondPageArguments(this.token, this.username);
}
