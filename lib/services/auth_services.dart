import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'loginpruebavelvars.somee.com'; //posible linea de conexion loginprueba.somee.com
  

  final storage = new FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien!
  
  Future<String?> createUser(String email, String password) async {//realiza solicitud http post, retorna error si hay problema
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      
    };

    final url = Uri.http(_baseUrl, '/api/Cuentas/registrar');

    final resp = await http.post(
  url,
  headers: {"Content-Type": "application/json"},
  body: json.encode(authData),
);

     print('Response body: ${resp.body}');
     final dynamic decodedResp = json.decode(resp.body); // Cambia a dynamic

      if (decodedResp is Map<String, dynamic> && decodedResp.containsKey('token')) {
       await storage.write(key: 'token', value: decodedResp['token']);
        return null;
      } else {
          return decodedResp['error']['message'];
        }
  }

  Future<String?> login(String email, String password) async {//realiza solicitud http post
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url = Uri.http(_baseUrl, '/api/Cuentas/login');

    final resp = await http.post(
        url,
         headers: {"Content-Type": "application/json"},
       body: json.encode(authData),
        );

        print('Response body: ${resp.body}');
          final dynamic decodedResp = json.decode(resp.body); // Cambia a dynamic

        if (decodedResp is Map<String, dynamic> && decodedResp.containsKey('token')) {
            await storage.write(key: 'token', value: decodedResp['token']);
            return null;
          } else {
         return decodedResp['error']['message'];
          }
  }

  Future logout() async {//elimina el token almacenado cerrando la sesion del usuario 
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {//lee el token 
    return await storage.read(key: 'token') ?? '';
  }
}
