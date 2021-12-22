import 'package:aplicacion1/pages/inicio_page.dart';
import 'package:aplicacion1/pages/listas_page.dart';
import 'package:aplicacion1/pages/mapa_page.dart';
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
        InicioPage.routeName: (_) => InicioPage(),
        MapaHome.routeName: (_) => MapaHome(),
        "/second": (BuildContext context) => PageTwo(),
      },
    );
  }
}
