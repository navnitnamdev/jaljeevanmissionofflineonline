
import 'dart:io' as io;
import 'package:jaljeevanmissiondynamic/localdatamodel/Userdata.dart';
import 'package:jaljeevanmissiondynamic/localdatamodel/Villagelistdatalocaldata.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../localdatamodel/DashboardLocalModal.dart';


class DatabaseHelperJalJeevan
{

  static Database? _database;

  DatabaseHelperJalJeevan.internal();
  static final DatabaseHelperJalJeevan instance = new DatabaseHelperJalJeevan.internal();

 // final  conn = DatabaseHelperJalJeevan.instance;

  factory DatabaseHelperJalJeevan()=> instance;

  Future<Database?> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabse();
    return _database;
  }

  initDatabse() async {
    io.Directory documentryDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentryDirectory.path, 'JalJeevanMission.db');
    var db = await openDatabase(path, version: 1, onCreate: _oncreate);
    return db;
  }

  _oncreate(Database db, int version) async {
    await db.execute("CREATE TABLE jaljeevantable_userprofile(id INTEGER PRIMARY KEY AUTOINCREMENT , userid TEXT, username  TEXT , mobilenumber TEXT , designation TEXT)");
    await db.execute("CREATE TABLE jaljeevanvillagelisttable(id INTEGER PRIMARY KEY AUTOINCREMENT , villageId TEXT,  villageName TEXT)");
    await db.execute("CREATE TABLE jaljeevantable_Dashboard(id INTEGER PRIMARY KEY AUTOINCREMENT , "
        " username TEXT,userdescription TEXT, leftheadingmenuid TEXT, "
        " leftheading TEXT ,  subheadingleftmenuid TEXT ,   SubHeadingleftmenu TEXT ,    leftmenulableMenuId TEXT , "
        " leftmenuLableText TEXT ,   leftmenuLableValue TEXT , leftmenuIcon TEXT    )");

    await db.execute("CREATE TABLE dashboardexampletable(id INTEGER PRIMARY KEY AUTOINCREMENT , "
        " username TEXT,userdescription TEXT, leftheadingmenuid TEXT, "
        " leftheading TEXT ,  subheadingleftmenuid TEXT ,   SubHeadingleftmenu TEXT ,    leftmenulableMenuId TEXT , "
        " leftmenuLableText TEXT ,   leftmenuLableValue TEXT , leftmenuIcon TEXT    )");
  }
/*  Future<Myresponse> insert(Myresponse myresponse) async {
    var dbClient = await db;
    await dbClient!.insert('jaljeevantable', myresponse.toJson());
    return myresponse;
  } */

  Future<DashboardLocalModal> insertDashboarddataindb(DashboardLocalModal dashboardLocalModal) async {
    var dbClient = await db;
    await dbClient!.insert('jaljeevantable_Dashboard', dashboardLocalModal.toMap());
    return dashboardLocalModal;
  }
  Future<void> insertData(List<DashboardLocalModal> dataList) async {
    var dbClient = await db;
    Batch batch = dbClient!.batch();
    for (DashboardLocalModal data in dataList) {
      batch.insert('dashboardexampletable', data.toMap());
    }
    await batch.commit();
    print("jampa");
    print(dataList);
  }
  Future<List<DashboardLocalModal>> getfatchdata() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query('dashboardexampletable');
    return List.generate(maps.length, (i) {
      return DashboardLocalModal.fromMap(maps[i]);
    });
  }
  Future<Userdata> insertuserprofile(Userdata userdata) async {
    var dbClient = await db;
    await dbClient!.insert('jaljeevantable_userprofile', userdata.toMap());
    return userdata;
  }

  Future<Villagelistlocaldata> insert_villagelist(Villagelistlocaldata villagelistlocaldata) async {

    var dbClient = await db;

    await dbClient!.insert('jaljeevanvillagelisttable', villagelistlocaldata.toMap());
    return villagelistlocaldata;
  }

  /*Future<List<Villagelistlocaldata>> fatchvillagelist() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('jaljeevanvillagelisttable');
    return queryResult.map((e) => Villagelistlocaldata.fromMap(e)).toList();
  }*/


  Future<List<Villagelistlocaldata>> fatchvillagelist() async {
    var dbClient = await instance.db;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('jaljeevanvillagelisttable');
    return queryResult.map((e) => Villagelistlocaldata.fromMap(e)).toList();
  }

  Future<List<Userdata>> fatchuserprofile() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('jaljeevantable_userprofile');
    return queryResult.map((e) => Userdata.fromMap(e)).toList();
  }



  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient!.delete('jaljeevantable', where: 'id = ?' , whereArgs: [id]);

  }


  Future<void> truncateTable() async {
    var dbClient = await db;

    // Truncate (delete all records) from the table
    await dbClient!.delete('jaljeevanvillagelisttable');
  }

 /* // update
  Future<int> update(Myresponse myresponse) async{
    var dbClient = await db;
    return await dbClient!.update('jaljeevantable', myresponse.toJson(), where: 'id = ?', whereArgs: [myresponse.userName]);

  }*/

}