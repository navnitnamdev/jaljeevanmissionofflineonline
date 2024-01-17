import 'package:jaljeevanmissiondynamic/database/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabse();
    return _db;
  }

  initDatabse() async {
    io.Directory documentryDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentryDirectory.path, 'JJMRecord.db');
    var db = await openDatabase(path, version: 1, onCreate: _oncreate);
    return db;
  }

  _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE jjmtable(id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT, age INTEGER NOT NULL , email TEXT)");
  }

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert('jjmtable', notesModel.toMap());
    return notesModel;
  }

  Future<List<NotesModel>> getnoteslist() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('jjmtable');
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }



  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient!.delete('jjmtable', where: 'id = ?' , whereArgs: [id]);

  }

  // update
  Future<int> update(NotesModel notesModel) async{
    var dbClient = await db;
    return await dbClient!.update('jjmtable', notesModel.toMap(), where: 'id = ?', whereArgs: [notesModel.id]);

  }
}
