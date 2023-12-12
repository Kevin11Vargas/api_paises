import 'package:api_paises_app/models/country_model.dart';
import 'package:api_paises_app/providers/database_helper.dart';
import 'package:api_paises_app/services/auth_services.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  final Country country;
  final AuthService authService;

  CountryDetails({required this.country, required this.authService});

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  late bool isFavorite = false;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    initializeFavoriteState();
  }

  // Función asincrónica para inicializar el estado de favorito
  Future<void> initializeFavoriteState() async {
    // Usa 'await' para esperar a que la función 'isFavorite' se complete
    isFavorite = await DatabaseHelper.instance.isFavorite(widget.country);

    // Actualiza el indicador de carga y vuelve a construir la interfaz de usuario
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              size: 30,  // Ajusta el tamaño del ícono aquí
              color: Colors.yellow,
            ),
            onPressed: () {
              setState(() {
                // Cambia el estado de favorito al presionar el botón
                isFavorite = !isFavorite;

                // Actualiza la base de datos según el estado de favorito
                if (isFavorite) {
                  DatabaseHelper.instance.addFavorite(widget.country);
                } else {
                  DatabaseHelper.instance.removeFavorite(widget.country);
                }
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/earth_background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nombre: ${widget.country.name}',
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                      ),
                      Text(
                        'Capital: ${widget.country.capital}',
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                      ),
                      Text(
                        'Región: ${widget.country.region}',
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                      ),
                      Image.network(widget.country.flagUrl, height: 490, width: 360),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
// class CountryDetails extends StatefulWidget {
//   final Country country;
//   final AuthService authService;

//   CountryDetails({required this.country, required this.authService});

//   @override
//   _CountryDetailsState createState() => _CountryDetailsState();
// }

// class _CountryDetailsState extends State<CountryDetails> {
//   late bool isFavorite;
//   late bool isLoading;

//   @override
//   void initState() {
//     super.initState();
//     isLoading = true;
//     initializeFavoriteState();
//   }

//   // Función asincrónica para inicializar el estado de favorito
//   Future<void> initializeFavoriteState() async {
//     // Usa 'await' para esperar a que la función 'isFavorite' se complete
//     isFavorite = await DatabaseHelper.instance.isFavorite(widget.country);

//     // Actualiza el indicador de carga y vuelve a construir la interfaz de usuario
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.country.name),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/earth_background.jpg'),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Center(
//           child: isLoading
//               ? CircularProgressIndicator()
//               : Padding(
//                   padding: const EdgeInsets.only(right: 10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Nombre: ${widget.country.name}',
//                         style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
//                       ),
//                       Text(
//                         'Capital: ${widget.country.capital}',
//                         style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
//                       ),
//                       Text(
//                         'Región: ${widget.country.region}',
//                         style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
//                       ),
//                       Image.network(widget.country.flagUrl, height: 350, width: 360),
//                       IconButton(
//                         icon: Icon(
//                           isFavorite ? Icons.star : Icons.star_border,
//                           color: Colors.yellow,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             // Cambia el estado de favorito al presionar el botón
//                             isFavorite = !isFavorite;

//                             // Actualiza la base de datos según el estado de favorito
//                             if (isFavorite) {
//                               DatabaseHelper.instance.addFavorite(widget.country);
//                             } else {
//                               DatabaseHelper.instance.removeFavorite(widget.country);
//                             }
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }