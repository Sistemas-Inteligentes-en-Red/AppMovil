import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  //variable para la pocicion
  final double size;
  const IconContainer({Key key, @required this.size})
      : assert(size != null && size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(this.size * 0.15),
        boxShadow: [
          BoxShadow(
            //xx 0, 153, 255, 0.5   254, 80, 0, 1
            color: Color.fromRGBO(0, 153, 255, 0.5),
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.all(this.size * 0.05),
      child: Center(
        child: Image.asset(
          "images/logo.png",
          width: this.size * 0.95,
          height: this.size * 0.95,
        ),
      ),
    );
  }
}
