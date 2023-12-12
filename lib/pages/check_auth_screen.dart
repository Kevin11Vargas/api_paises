import 'package:api_paises_app/pages/login_screen.dart';
import 'package:api_paises_app/screens/home_screen.dart';
import 'package:api_paises_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(//•	Utiliza un FutureBuilder para esperar la lectura del token de autenticación a través del servicio AuthService
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return Text('');//si no hay datos en anapshot devuelve un widget de texto vacio

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginScreen(),//si el token es cadena vacia redirije a la pantalla login 
                        transitionDuration: Duration(seconds: 0)));
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(authService: authService),//si hay un token se redirije a la pantalla principal
                        transitionDuration: Duration(seconds: 0)));
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
