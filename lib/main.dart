import 'package:api_paises_app/pages/check_auth_screen.dart';
import 'package:api_paises_app/pages/login_screen.dart';
import 'package:api_paises_app/pages/register_screen.dart';
import 'package:api_paises_app/screens/favoritos_screen.dart';
import 'package:api_paises_app/screens/home_screen.dart';
import 'package:api_paises_app/services/auth_services.dart';
import 'package:api_paises_app/services/notifications_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      initialRoute: 'checking',
      routes: {
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'home': (_) => HomeScreen(authService: AuthService()),
        'checking': (_) => CheckAuthScreen(),
        'favoritos': (_) => FavoritosScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,

      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Color.fromARGB(255, 75, 75, 75),
          appBarTheme: const AppBarTheme(elevation: 0, color: Color.fromARGB(255, 75, 75, 75)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.redAccent, elevation: 0)),
    );
  }
}



