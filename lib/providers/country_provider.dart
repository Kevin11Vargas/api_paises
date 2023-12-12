import 'package:api_paises_app/models/country_model.dart';
import 'package:dio/dio.dart';

class CountryProvider {
  final Dio _dio = Dio();

  Future<List<Country>> getCountries() async {
    try {
      final response = await _dio.get('https://restcountries.com/v3.1/all');
      if (response.statusCode == 200) {
        final List<Country> countries = (response.data as List)
            .map((json) => Country.fromJson(json))
            .toList();
        return countries;
      } else {
        print('Failed to load countries: ${response.statusCode}');
        print('Response body: ${response.data}');
        throw Exception('Failed to load countries: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.message}');
      }
      print('Failed to load countries: $e');
      throw Exception('Failed to load countries');
    }
  }
}