import 'dart:io';
import 'dart:async';

import 'package:give_me_visa/entity/country.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class DBProvider {

  final databaseLocalName = "local.db";
  final databaseAssetName = "myowndb.db";

  final assetFolderName = "assets";

  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, databaseLocalName);

    // try opening (will work if it exists)
    Database db;
    try {
      db = await openDatabase(path, readOnly: true);
      if (db != null) {
        print("Database initialization - working with local copy");
        return db;
      }
    } catch (e) {
      print("Error $e");
    }

    // Should happen only the first time you launch your application
    print("Database initialization - Creating new copy from asset");

    // Copy from asset
    ByteData data = await rootBundle.load(join(assetFolderName, databaseAssetName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await new File(path).writeAsBytes(bytes);

    // open the database
    return await openDatabase(path, readOnly: true);
  }

  Future<List<Country>> getCountries() async {
    final db = await database;

    var result = await db.query(Country.tableName);

    var mappedResult = result.isNotEmpty
        ? result.map((jsonCountry) => Country.fromJson(jsonCountry)).toList()
        : [];

    return mappedResult;
  }
}