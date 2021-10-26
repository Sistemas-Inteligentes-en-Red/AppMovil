import 'package:aplicacion1/pages/inicio_page.dart';
import 'package:aplicacion1/pages/listas_page.dart';
import 'package:aplicacion1/pages/mapa_page.dart';
import 'package:aplicacion1/pages/punto.dart';
import 'package:aplicacion1/pages/rutas_page.dart';
import 'package:aplicacion1/pages/puntos.dart';
import 'package:aplicacion1/pages/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //para que las pantallas no roten
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        RegisterPage.routeName: (_) => RegisterPage(),
        LoginPage.routeName: (_) => LoginPage(),
        //HomePage.routeNme: (_) => HomePage(),
        InicioPage.routeName: (_) => InicioPage(),
        ListaPage.routeName: (_) => ListaPage(),
        MapaHome.routeName: (_) => MapaHome(),
        PuntosRuta.routeName: (_) => PuntosRuta(),
        PointPage.routeName: (_) => PointPage(),
        //PageTwo.routeName: (_) => PageTwo(),
        "/second": (BuildContext context) => PageTwo(),
      },
    );
  }
}
