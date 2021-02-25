import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

//Create database script.
final initialScript = [
  '''
    CREATE TABLE Posts (
      localId INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      title TEXT,
      author_fullname TEXT
    );
  ''',
];

final migrations = [];

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //Create path to local database file.
    String path = join(documentsDirectory.path, "reddit_stream.db");
    return await openDatabase(
      path,
      version: getVersion(),
      onOpen: (db) {},
      //Method to create db when non exists.
      onCreate: (Database db, int version) async {
        var batch = db.batch();

        initialScript.forEach((script) => batch.execute(script));
        migrations.forEach((script) => batch.execute(script));

        await batch.commit();
      },
      //Method for upgrading database when already present.
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < newVersion) {
          var batch = db.batch();

          for (int i = oldVersion - 1; i <= newVersion - 1; i++) {
            batch.execute(migrations[i]);
          }

          await batch.commit();
        }
      },
    );
  }

  int getVersion() {
    return initialScript.length + migrations.length;
  }
}
