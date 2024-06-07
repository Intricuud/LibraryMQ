import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  // Declare user database instance
  static Database? _database;
  static const String dbName = 'user.db';
  static const String tableName = 'users';

  // Getter method for getting the database for user
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  // Function for initialise the database
  static Future<Database> initializeDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT
          )
        ''');
      },
    );
  }

  // Inserting the user into the database
  static Future<int> insertUser(String name, String email) async {
    final db = await database;
    return await db.insert(tableName, {'name': name, 'email': email});
  }

  // Getter method for getting user from the database
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query(tableName);
  }
}
