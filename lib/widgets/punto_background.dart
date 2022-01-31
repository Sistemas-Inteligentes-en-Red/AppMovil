import 'package:flutter/material.dart';

class AuthBacground extends StatelessWidget {
  //
  final Widget child;
  const AuthBacground({Key key, @required this.child}) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          this.child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        child: Image.asset(
          'images/avatar.png',
          width: 100,
          height: 100,
          color: Colors.white60,
        ),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // para trabajar con las medidas del dispositivo
    final size = MediaQuery.of(context).size;
    //
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purplrBackground(),
      child: Stack(
        children: [
          Positioned(child: _Bubble(), top: 90, left: 30),
          Positioned(child: _Bubble(), top: -40, left: -30),
          Positioned(child: _Bubble(), top: -50, right: -20),
          Positioned(child: _Bubble(), bottom: -50, left: 10),
          Positioned(child: _Bubble(), bottom: 120, right: 20),
        ],
      ),
    );
  }

  BoxDecoration _purplrBackground() => BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(0, 48, 135, 1),
          Color.fromRGBO(0, 92, 153, 1),
        ]),
      );
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
