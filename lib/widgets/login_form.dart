import 'package:aplicacion1/api/authentication_api.dart';
import 'package:aplicacion1/pages/inicio_page.dart';
import 'package:aplicacion1/utils/dialogs.dart';
import 'package:aplicacion1/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'input_text.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', token = '', username = '';
  AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  Future<void> _submit() async {
    final isOk = _formKey.currentState.validate();
    //print("form isOk $isOk");
    if (isOk) {
      ProgressDialog.show(context);
      final response = await _authenticationAPI.login(
        email: _email,
        password: _password,
      );
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        token = response.data['token'];
        username = response.data['username'];
        //print(token);
        //print(username);
        Navigator.pushNamedAndRemoveUntil(
            context, InicioPage.routeName, (_) => false,
            arguments: SecondPageArguments(username, token));
      } else {
        String message = response.error.message;
        if (response.error.statusCode == -1) {
          message = "Sin Internet";
        } else if (response.error.statusCode == 400) {
          message = "Correo o Contraseña invalida";
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
    //
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
                label: "CORREO ELECTRONICO",
                fontZise: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text;
                },
                validator: (text) {
                  if (!text.contains("@")) {
                    return "Correo no Valido";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InputText(
                        label: "CONTRASEÑA",
                        obscureText: true,
                        borderEnabled: false,
                        fontZise:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                        onChanged: (text) {
                          _password = text;
                        },
                        validator: (text) {
                          if (text.trim().length == 0) {
                            return "Contraseña no valida";
                          }
                          return null;
                        },
                      ),
                    ),
                    // MaterialButton(
                    // padding: EdgeInsets.symmetric(vertical: 10),
                    // child: Text(
                    //  "haz olvidado tu contraseña?",
                    //  style: TextStyle(
                    //   fontWeight: FontWeight.bold,
                    //  fontSize:
                    //   responsive.dp(responsive.isTablet ? 1.2 : 1.4)),
                    //),
                    // onPressed: () {
                    //   print("Restablecer Contraseña");
                    //},
                    //),
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(5)),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Iniciar Seccion",
                    style: TextStyle(
                        color: Colors.white, fontSize: responsive.dp(1.5)),
                  ),
                  onPressed: this._submit,
                  color: Color.fromRGBO(254, 80, 0, 1),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              //Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              // children: [
              //Text(
              // "No Tienes Cuenta?",
              // style: TextStyle(fontSize: responsive.dp(1.5)),
              // ),
              //MaterialButton(
              //child: Text(
              //"Registrate",
              //style: TextStyle(
              //color: Color.fromRGBO(254, 80, 0, 1),
              // fontSize: responsive.dp(1.5)),
              // ),
              //onPressed: () {
              //  Navigator.pushNamed(context, 'register');
              // },
              // ),
              //],
              //),
              SizedBox(height: responsive.dp(10)),
            ],
          ),
        ),
      ),
    );
  }
}
