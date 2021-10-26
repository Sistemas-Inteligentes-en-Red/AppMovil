import 'package:aplicacion1/utils/responsive.dart';
import 'package:aplicacion1/widgets/avatar_button.dart';
import 'package:aplicacion1/widgets/circle.dart';
import 'package:aplicacion1/widgets/register_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  static const routeName = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    //responsibe
    final Responsive responsive = Responsive.of(context);
    final double blueSize = responsive.wp(82);
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
                  top: -blueSize * 0.25,
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
                  top: -orangeSize * 0.45,
                  left: -orangeSize * 0.15,
                  child: Circle(
                    size: orangeSize,
                    colors: [
                      // Color.fromRGBO(255, 255, 255, 1),
                      // Color.fromRGBO(254, 80, 0, 1),
                      Color.fromRGBO(0, 153, 255, 0.5),
                      Color.fromRGBO(0, 92, 153, 0.8),
                    ],
                  ),
                ),
                Positioned(
                  top: blueSize * 0.21,
                  child: Column(
                    children: [
                      Text(
                        'SIER\nPgina de Registro',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.6),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: responsive.dp(5)),
                      AvatarButton(
                        imageSize: responsive.wp(25),
                      ),
                    ],
                  ),
                ),
                RegisterForm(),
                Positioned(
                  left: 15,
                  top: 10,
                  child: SafeArea(
                    child: CupertinoButton(
                      color: Colors.white24,
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(30),
                      child: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
