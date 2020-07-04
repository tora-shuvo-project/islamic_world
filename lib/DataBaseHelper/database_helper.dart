import 'package:searchtosu/FinalModels/audio_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class DatabaseHelper{
  static final databaseName='ISLAM.db';
  static final databaseVersion=1;
  static final suraTable='SuraNameTbl';
  static final ayatTable='AyatTbl';
  static final audioTable='AudioTbl';
  static final columnSuraNo='SURANO';
  static final columnQarename='QARINAME';
  static final columnEnglishName='ENGLISHSURANAME';
  static final columnBanglaName='BANGLATRANSLATOR';
  static final columnArabi='ARABISURANAME';
  static final columnobotirno='OBOTIRNO';

  DatabaseHelper._privateConstrator();
  static final DatabaseHelper instance=DatabaseHelper._privateConstrator();

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

  //Select All
  Future<List> getAllSuraFromSuraNameTable()async{
    Database db=await instance.database;
    var result=await db.query(suraTable);
    return result.toList();
  }

  Future<List> searchSuraFromSuraNameTable(String name)async{
    Database db=await instance.database;
    var result=await db.rawQuery(" SELECT * FROM $suraTable WHERE  $columnEnglishName LIKE '%$name%' OR $columnBanglaName LIKE '%${name}%' OR $columnArabi LIKE '%${name}%' OR $columnSuraNo LIKE '%${name}%' OR $columnobotirno LIKE '%${name}%' ");
    return result.toList();
  }
  

  Future<List> getAllAyatFromAyatTable(int suraNo)async{
    Database db=await instance.database;
//    var result=await db.rawQuery('SELECT * FROM $ayatTable WHERE SURANO=$suraNo;');
    var result=await db.query(ayatTable,where: '$columnSuraNo= ?',whereArgs: [suraNo]);
    return result.toList();
  }

  Future<AudioModels> getAudioBySuraAndQareName(int surano,String qarename)async{
    Database db=await instance.database;
    final List<Map<String,dynamic>> qareNames=await db.query(audioTable,where: '$columnSuraNo = ? AND $columnQarename = ?',whereArgs: [surano,qarename]);
    if(qareNames.length>0){
      return AudioModels.fromMap(qareNames.first);
    }
    return null;
  }

}