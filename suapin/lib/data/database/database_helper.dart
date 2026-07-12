import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/anotacao_model.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  static const String _databaseName = 'suapin_notas.db';
  static const String _tableName = 'anotacoes';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = join(databasesPath, _databaseName);

    return openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        conteudo TEXT NOT NULL,
        disciplina TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(AnotacaoModel anotacao) async {
    final db = await database;
    return db.insert(_tableName, anotacao.toMap());
  }

  Future<List<AnotacaoModel>> queryAll() async {
    final db = await database;
    final result = await db.query(_tableName, orderBy: 'id DESC');

    return result.map(AnotacaoModel.fromMap).toList();
  }

  Future<int> update(AnotacaoModel anotacao) async {
    if (anotacao.id == null) {
      return 0;
    }

    final db = await database;
    final values = Map<String, dynamic>.from(anotacao.toMap())..remove('id');

    return db.update(
      _tableName,
      values,
      where: 'id = ?',
      whereArgs: [anotacao.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
