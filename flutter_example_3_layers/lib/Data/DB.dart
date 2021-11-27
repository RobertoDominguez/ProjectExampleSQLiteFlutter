import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{

  static const DB_NAME= 'memos.db';
  static const DB_VERSION = 1;
  ////////////////////////////////////////////////

  static Future<Database> openDB() async{

    return openDatabase(
      join(await getDatabasesPath(),DB_NAME),
      onCreate: (db,version){
        sql().forEach((element) {
          db.execute(element);
        });
      },
        version: DB_VERSION
    );
  }

  static Future<void> deleteDB() async{
    return deleteDatabase(join(await getDatabasesPath(),DB_NAME));
  }

  static List<String> sql(){
    return
      [
        "CREATE TABLE USER ("
            "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
            "NAME TEXT NOT NULL,"
            "EMAIL TEXT NOT NULL UNIQUE,"
            "PASSWORD TEXT NOT NULL"
            ");",
        "CREATE TABLE MEMO ("
            "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
            "TITLE TEXT NOT NULL,"
            "CONTENT TEXT NOT NULL,"
            "USER_ID INTEGER NOT NULL,"
            "FOREIGN KEY(USER_ID) REFERENCES USER(ID) ON DELETE CASCADE ON UPDATE CASCADE"
            ");"
      ];

  }
}

