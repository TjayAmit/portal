import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:zcmc_portal/src/authentication/model/user_model.dart';


class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();
  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id TEXT NOT NULL,
        name TEXT NOT NULL,
        authorization_pin TEXT NOT NULL,
        personal_information TEXT,
        contact TEXT,
        designation TEXT
      )
    ''');
  }

  Future<int> insertUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert(
      'users',
      {
        'id': user.id,
        'employee_id': user.employeeId,
        'name': user.name,
        'authorization_pin': user.authorizationPin,
        'personal_information': jsonEncode(user.personalInformation.toJson()),
        'contact': jsonEncode(user.contact.toJson()),
        'designation': jsonEncode(user.designation.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert or update a user
  Future<int> upsertUser(UserModel user) async {
    final db = await instance.database;

    return await db.insert(
      'users',
      {
        'employee_id': user.employeeId,
        'name': user.name,
        'authorization_pin': user.authorizationPin,
        'personal_information': jsonEncode(user.personalInformation.toJson()),
        'contact': jsonEncode(user.contact.toJson()),
        'designation': jsonEncode(user.designation.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get user by employeeId
  Future<UserModel?> getUserByEmployeeId(String employeeId) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'employee_id = ?',
      whereArgs: [employeeId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  // Get all users
  Future<List<UserModel>> getAllUsers() async {
    final db = await instance.database;
    final result = await db.query('users');

    return result.map((row) => UserModel.fromMap(row)).toList();
  }

  // Delete user
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Close database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
