import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openhab_flutter/helpers/mostrar_alerta.dart';
import 'package:openhab_flutter/helpers/validar.dart';
import 'package:openhab_flutter/services/setupServer_service.dart';
import 'package:openhab_flutter/widgets/Buttons/boton_principal.dart';
import 'package:openhab_flutter/widgets/form_field_input.dart';
import 'package:openhab_flutter/widgets/logo/appname_widget.dart';
import 'package:openhab_flutter/widgets/logo/logo_widget.dart';
import 'package:provider/provider.dart';

class SetupPage extends StatefulWidget {
  // SetupPage({Key key}) : super(key: key);

  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  // final validar = Validar();
  final urlServer = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _systemChromeColor(Brightness.dark);
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).primaryColor;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  child: Text('Conexion',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
                ),
                _crearLogo(size, color),
                Expanded(child: SizedBox()),
                Text(
                  'Registrar Servidor Remoto',
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 124, 125, 126)),
                ),
                _Form(),
                SizedBox(height: 20),
                SizedBox(height: 30),
                _noTienesCuenta(context),
                SizedBox(
                  height: 0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _crearLogo(Size size, Color color) {
    return Hero(
        tag: 'logo',
        transitionOnUserGestures: true,
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            children: [
              LogoWidget(width: size.width),
              AppNameWidget(width: size.width, color: color)
            ],
          ),
        ));
  }

  void _systemChromeColor(Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: brightness,
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
      ),
    );
  }
}

Widget _noTienesCuenta(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '¿No dispone de un servidor de OH? ',
        style:
            TextStyle(fontSize: 14, color: Color.fromARGB(255, 124, 125, 126)),
      ),
      GestureDetector(
        onTap: () {
          mostrarAlerta(context, "Acceso denegado", "Working");
        },
        child: Text(
          'Inicia',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Theme.of(context).primaryColor),
        ),
      ),
    ],
  );
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final urlServer = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final setupServerService = Provider.of<SetupServerService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            FormFieldInput(
              validator: (value) {
                return Validar().validarUrl(value!);
              },
              onChanged: null,
              placeholder: 'URL Servidor',
              labelText: 'URL Servidor Remoto',
              keyboardType: TextInputType.url,
              textController: urlServer,
            ),
            SizedBox(height: 20),
            BotonPrincipal(
              text: 'Iniciar',
              onPressed: () async {
                FocusScope.of(context).unfocus();
                final formValidate = formKey.currentState!.validate();

                if (!formValidate) return null;

                final setupOk =
                    await setupServerService.setupServer(urlServer.text.trim());

                if (setupOk) {
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, 'home', (Route<dynamic> route) => false);
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'home', (Route<dynamic> route) => false);
                } else {
                  mostrarAlerta(context, 'setup incorrecto',
                      'Datos ingresados no validos');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
