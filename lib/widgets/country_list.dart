import 'package:api_paises_app/details/country_details.dart';
import 'package:api_paises_app/models/country_model.dart';
import 'package:api_paises_app/services/auth_services.dart';
import 'package:flutter/material.dart';

class CountryList extends StatefulWidget {
  final List<Country> countries;
  final AuthService authService;

  CountryList({required this.countries, required this.authService});

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.countries.length,
      itemBuilder: (context, index) {
        final country = widget.countries[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryDetails(country: country, authService: widget.authService),
              ),
            );
          },
          child: Card(
            color: Colors.white.withOpacity(0.35),
            child: ListTile(
              leading: Image.network(country.flagUrl, height: 48, width: 48),
              title: Text(country.name),
              subtitle: Text(country.region),
            ),
          ),
        );
      },
    );
  }
}