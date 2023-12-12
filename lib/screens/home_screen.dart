import 'package:api_paises_app/models/country_model.dart';
import 'package:api_paises_app/providers/country_provider.dart';
import 'package:api_paises_app/services/auth_services.dart';
import 'package:api_paises_app/widgets/country_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final CountryProvider countryProvider = CountryProvider();
  final AuthService authService;

  HomeScreen({required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paises del mundo'),
        leading: IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () async {
            await authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.pushNamed(context, 'favoritos');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/earth_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: countryProvider.getCountries(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Country> countries = snapshot.data as List<Country>;
              return CountryList(countries: countries, authService: authService);
            }
          },
        ),
      ),
    );
  }
}