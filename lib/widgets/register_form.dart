import 'package:aplicacion1/api/authentication_api.dart';
import 'package:aplicacion1/pages/home_page.dart';
import 'package:aplicacion1/utils/dialogs.dart';
import 'package:aplicacion1/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'input_text.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username;
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  Logger _logger = Logger();
  Future<void> _submit() async {
    final isOk = _formKey.currentState.validate();
    print("form isOk $isOk");
    if (isOk) {
      ProgressDialog.show(context);
      final response = await _authenticationAPI.register(
        username: _username,
        email: _email,
        password: _password,
      );
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        _logger.i("Registro Exitoso ::: ${response.data}");
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeNme,
          (_) => false,
        );
      } else {
        _logger.e("Error en Registro status code ${response.error.statusCode}");
        _logger.e("Error en Registro message ${response.error.message}");
        _logger.e("Error en Registro data ${response.error.data}");

        String message = response.error.message;
        if (response.error.statusCode == -1) {
          message = "Sin Internet";
        } else if (response.error.statusCode == 409) {
          message = "Usuario Duplicado";
        }
        Dialogs.alert(
          context,
          tittle: "Error",
          description: message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "NOMBRE DE USUARIO",
                fontZise: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _username = text;
                },
                validator: (text) {
                  if (text.trim().length < 5) {
                    return "Invalid username";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "CORREO ELECTRONICO",
                fontZise: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text;
                },
                validator: (text) {
                  if (!text.contains("@")) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "CONTRASEÑA",
                obscureText: true,
                fontZise: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _password = text;
                },
                validator: (text) {
                  if (text.trim().length < 6) {
                    return "Invalid password";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(5)),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                        color: Colors.white, fontSize: responsive.dp(1.5)),
                  ),
                  onPressed: this._submit,
                  color: Color.fromRGBO(254, 80, 0, 1),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ya tengo una cuenta?",
                    style: TextStyle(fontSize: responsive.dp(1.5)),
                  ),
                  MaterialButton(
                    child: Text(
                      "Ingresar",
                      style: TextStyle(
                          color: Color.fromRGBO(254, 80, 0, 1),
                          fontSize: responsive.dp(1.5)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: responsive.dp(10)),
            ],
          ),
        ),
      ),
    );
  }
}
