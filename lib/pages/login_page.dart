import 'package:aplicacion1/utils/responsive.dart';
import 'package:aplicacion1/widgets/circle.dart';
import 'package:aplicacion1/widgets/icon_continer.dart';
import 'package:aplicacion1/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  static const routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //responsibe
    final Responsive responsive = Responsive.of(context);
    final double blueSize = responsive.wp(80);
    final double orangeSize = responsive.hp(35);
    //
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        //GestureDetectos es para quitar el teclado el foco
        //Single es pra que al salir los teclado no se suba
        //es necesario cambiar el infinito de el containes
        child: SingleChildScrollView(
          child: Container(
            width: responsive.width,
            height: responsive.heigth,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -blueSize * 0.30,
                  right: -blueSize * 0.2,
                  child: Circle(
                    size: blueSize,
                    colors: [
                      Color.fromRGBO(0, 153, 255, 1),
                      Color.fromRGBO(0, 48, 135, 1),
                    ],
                  ),
                ),
                Positioned(
                  top: -orangeSize * 0.50,
                  left: -orangeSize * 0.15,
                  child: Circle(
                    size: orangeSize,
                    colors: [
                      Color.fromRGBO(0, 153, 255, 0.5),
                      Color.fromRGBO(0, 92, 153, 0.8),
                    ],
                  ),
                ),
                Positioned(
                  top: blueSize * 0.48,
                  child: Column(
                    children: [
                      IconContainer(
                        size: responsive.wp(23),
                      ),
                      SizedBox(
                        height: responsive.dp(4),
                      ),
                      Text(
                        'APPI  TRACK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(2.5),
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(0, 48, 135, 1),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
