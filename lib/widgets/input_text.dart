import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText, borderEnabled;
  final double fontZise;
  final void Function(String) onChanged;
  final String Function(String text) validator;
  const InputText({
    Key key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
    this.fontZise = 15,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.keyboardType,
      obscureText: this.obscureText,
      onChanged: this.onChanged,
      // para mostrar letra por letra print(":::::$text");(text)
      validator: this.validator,
      style: TextStyle(fontSize: this.fontZise),
      decoration: InputDecoration(
        //suffix: Text("Forgot Password"), aparece con el foco
        labelText: this.label,
        contentPadding: EdgeInsets.symmetric(vertical: 6),

        enabledBorder: this.borderEnabled
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black12,
                ),
              )
            : InputBorder.none,
        labelStyle: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
