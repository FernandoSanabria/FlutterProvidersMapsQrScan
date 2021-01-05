import 'dart:io';

import 'package:enero4ejemplo1/src/models/random_value_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database _database;

  static final DatabaseService databaseService = DatabaseService._();

  DatabaseService._();

  Future<Database> get databaseFuture async {
    if (_database != null) return _database;

    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'dbRandomValues');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE random_value(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
        ''');
    });
  }

  Future<int> insertData(RandomValueModel item) async {
    final db = await databaseFuture;
    final res = await db.insert('random_value', item.toJson());

    return res;
  }

  Future<List<RandomValueModel>> getData(tipo) async {
    final db = await databaseFuture;

    List<Map> maps =
        await db.rawQuery('SELECT * FROM random_value WHERE tipo="$tipo"');

    var data = List.generate(maps.length, (i) {
      return RandomValueModel(
        id: maps[i]['id'],
        tipo: maps[i]['tipo'],
        valor: maps[i]['valor'],
      );
    });

    return data;
  }

Future<void> deleteAllByType(tipo) async {
    try {
      final db = await databaseFuture;
      await db.execute('DELETE FROM random_value WHERE tipo="$tipo"');
    } catch (e) {
      print(e);
    }
  }

  // Future<List<RandomValueModel>>

}
