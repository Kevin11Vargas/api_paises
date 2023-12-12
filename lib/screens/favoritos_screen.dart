import 'package:api_paises_app/details/country_details.dart';
import 'package:api_paises_app/providers/database_helper.dart';
import 'package:api_paises_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:api_paises_app/models/country_model.dart';

class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  late List<Country> favoritos = [];

  @override
  void initState() {
    super.initState();
    cargarFavoritos();
  }

  void cargarFavoritos() async {
    final List<Country> favoritosList = await DatabaseHelper.instance.getFavorites();

    setState(() {
      favoritos = favoritosList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Países Favoritos'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 175, 174, 174), // Fondo blanco
        child: favoritos.isEmpty
            ? Center(child: Text('No hay países favoritos.'))
            : ListView.builder(
                itemCount: favoritos.length,
                itemBuilder: (context, index) {
                  final country = favoritos[index];
                  return ListTile(
                    onTap: () {
                      // Navegar a los detalles del país al hacer clic
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountryDetails(
                            country: country,
                            authService: AuthService(), // Asegúrate de proporcionar una instancia de AuthService
                          ),
                        ),
                      );
                    },
                    leading: Image.network(country.flagUrl, height: 48, width: 48),
                    title: Text(country.name),
                    subtitle: Text(country.region),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await DatabaseHelper.instance.removeFavorite(country);
                        setState(() {
                          favoritos.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}