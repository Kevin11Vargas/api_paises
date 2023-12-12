class Country {
  final String name;
  final String capital;
  final String region;
  final String flagUrl;

  Country({
    required this.name,
    required this.capital,
    required this.region,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? '',
      capital: _parseStringList(json['capital']) ?? '',
      region: json['region'] ?? '',
      flagUrl: _parseStringList(json['flags']['png']) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'capital': capital,
      'region': region,
      'flagUrl': flagUrl,
    };
  }

  static String _parseStringList(dynamic value) {
    if (value is List<dynamic> && value.isNotEmpty) {
      return value.first.toString();
    } else if (value is String) {
      return value;
    }
    return '';
  }
}