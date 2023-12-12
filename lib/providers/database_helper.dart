import 'package:api_paises_app/models/country_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'countries_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        name TEXT PRIMARY KEY,
        capital TEXT,
        region TEXT,
        flagUrl TEXT
      )
    ''');
  }

  Future<void> addFavorite(Country country) async {
    final Database db = await database;

    await db.insert(
      'favorites',
      country.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(Country country) async {
    final Database db = await database;

    await db.delete(
      'favorites',
      where: 'name = ?',
      whereArgs: [country.name],
    );
  }

  Future<bool> isFavorite(Country country) async {
    final Database db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'favorites',
      where: 'name = ?',
      whereArgs: [country.name],
    );

    return result.isNotEmpty;
  }

  Future<List<Country>> getFavorites() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return Country(
        name: maps[i]['name'],
        capital: maps[i]['capital'],
        region: maps[i]['region'],
        flagUrl: maps[i]['flagUrl'],
      );
    });
  }

  Future<void> clearFavorites() async {
    final Database db = await database;
    await db.delete('favorites');
  }
}