import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:testme/model/user.dart';

/// the database helper
///
class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late final Database? _db;

  DatabaseHelper() {
    initDB();
  }

  // ensure _db initialized
  ensureDb() {
    if (_db == null) {
      initDB();
    }
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    // if _ initialized
    
    _db = await openDatabase(
      join(path, 'testme.db!'),
      onCreate: (database, version) async {
        await database.execute(
          """
           CREATE TABLE users (
            uuid VARCHAR(255) PRIMARY KEY,
            gender VARCHAR(255),
            title VARCHAR(255),
            email VARCHAR(255),
            firstName VARCHAR(255),
            lastName VARCHAR(255),
            username VARCHAR(255),
            password VARCHAR(255),
            phone VARCHAR(255),
            nat VARCHAR(50),
            dob_date VARCHAR(255),
            dob_age INT,
            registered_date VARCHAR(255),
            registered_age INT,
            location_city VARCHAR(255),
            location_state VARCHAR(255),
            location_country VARCHAR(255),
            location_postcode VARCHAR(255),
            picture_large VARCHAR(255),
            picture_medium VARCHAR(255),
            picture_thumbnail VARCHAR(255)
          );
          """,
        );
      },
      version: 3,
    );
  }

  // insert user into table
  Future<int> insertUser(User user) async {
    // ensureDb();
    return await _db!.insert('users', user.toJson());
  }

  // insert users into table
  Future<int> insertUsers(List<User> users) async {
    // ensureDb();
    int result = 0;
    for (User user in users) {
      result += await _db!.insert('users', user.toJson());
    }

    return result;
  }

  // paginate datas
  Future<List<User>> getUsers({int limit = 15, int offset = 0}) async {
    // ensureDb();
    final List<Map<String, dynamic>> maps = await _db!.query(
      'users',
      limit: limit,
      offset: offset, // offset en francais : 
    );
    if (kDebugMode) {
      print(maps);
    }
    return List.generate(maps.length, (i) {
      return User.fromDb(maps[i]);
    });
  }

  // get number of users in table
  Future<int> countUsers() async {
    // ensureDb();
    final List<Map<String, dynamic>> maps = await _db!.query('users');
    return maps.length;
  }

  // get user by uuid
  Future<User?> getUser(String uuid) async {
    // ensureDb();
    final List<Map<String, dynamic>> maps = await _db!.query(
      'users',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
    if (maps.isEmpty) {
      return null;
    }
    return User.fromDb(maps.first);
  }

  Future<int> updateUser(User user) async {
    // ensureDb();
    int result = await _db!.update(
      'users',
      user.toJson(),
      where: "uuid = ?",
      whereArgs: [user.uuid],
    );
    return result;
  }

  Future<void> deleteUser(User user) async {
    // ensureDb();
    await _db!.delete(
      'users',
      where: "uuid = ?",
      whereArgs: [user.uuid],
    );
  }

  // delete all users from table
  Future<int> deleteAllUsers() async {
    // ensureDb();
    return await _db!.delete('users');
  }

  // close database
  Future<void> close() async {
    await _db!.close();
  }
}
