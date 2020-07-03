import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class SuraNameTableDBHelper{
  static final databaseName='ISLAM.db';
  static final databaseVersion=1;
  static final suraNametablename='SuraNameTbl';
  static final SuraNoColumn='SURANO';
  static final AyatNOColumn='AYATNO';
  static final paraNumberColumn='PARANUMBER';
  static final arbiSuraNameColumn='ARBISURANAME';
  static final banglameaningColumn='BANGLAMEANING';
  static final banglaTranslatorColumn='BANGLATRANSLATOR';
  static final obotirnoColumn='OBOTIRNO';
  static final englishSuraNameColumn='ENGLISHSURANAME';

  SuraNameTableDBHelper._privateConstrator();
  static final SuraNameTableDBHelper instance=SuraNameTableDBHelper._privateConstrator();

  static Database _database;
  Future<Database> get database async{
    if(_database!=null)return _database;
    _database=await _initDatabase();
    return _database;
  }

  _initDatabase() async{
    var databasePath=await getDatabasesPath();
    String path=join(databasePath,databaseName);

    var exists=await databaseExists(path);
    if(!exists){
      print('Copy Database Start');

      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){}

      ByteData data=await rootBundle.load(join("assets",databaseName));
      List<int> bytes=data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

      //write
      await File(path).writeAsBytes(bytes,flush: true);

    }else{
      print('Opening existing database');
    }

    return await openDatabase(path,version: databaseVersion);
  }

  ///CRUD
  ///==========================================================
  // Insert
  Future<int> insert(Map<String,dynamic> row)async{
    Database db=await instance.database;
    return await db.insert(suraNametablename, row,nullColumnHack: null);
  }

  //Select All
  Future<List> getAllSuraFromSuraNameTable()async{
    Database db=await instance.database;
    var result=await db.query(suraNametablename);
    return result.toList();
  }

}