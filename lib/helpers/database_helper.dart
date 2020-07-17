import 'package:searchtosu/FinalModels/audio_models.dart';
import 'package:searchtosu/FinalModels/ojifa_models.dart';
import 'package:searchtosu/FinalModels/prayer_time_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class DatabaseHelper{
  static final databaseName='ISLAM.db';
  static final databaseVersion=1;

  //Table Name
  static final suraTable='SuraNameTbl';
  static final ayatTable='AyatTbl';
  static final audioTable='AudioTbl';
  static final paraTable='ParaNameTbl';
  static final prayerTimeTable='PrayerTimeTbl';
  static final quranWordTable='QuranWorkMeaningTbl';
  static final ojifaTable='OjifaTbl';
  static final dunaNameTable='DuaNameTbl';
  static final duyaDetailsTable='DuaDetailsTbl';
  static final hadisTable='HadisTbl';

  //Column Name
  static final columnSuraNo='SURANO';
  static final columnQarename='QARINAME';
  static final columnEnglishName='ENGLISHSURANAME';
  static final columnBanglaName='BANGLATRANSLATOR';
  static final columnArabi='ARABISURANAME';
  static final columnobotirno='OBOTIRNO';
  static final columnparaNo='PARA';
  static final columndate='DATEPRAYER';
  static final columntopicNo='TOPICNO';
  static final columnsubtopicNo='SUBTOPICNO';
  static final columndoyaID='ID';

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

  static Future<List> getAllHadisFromHadisTable()async{
    Database db=await instance.database;
    var result=await db.query(hadisTable);
    return result.toList();
  }

  static Future<List> getAllParaNameFromTable()async{
    Database db=await instance.database;
    var result=await db.query(paraTable);
    return result.toList();
  }
  static Future<List> getAllQuranWordFromTable()async{
    Database db=await instance.database;
    var result=await db.query(quranWordTable);
    return result.toList();
  }

  static Future<List> getAllAyatFromParaTable(int paraNo)async{
    Database db=await instance.database;
//    var result=await db.rawQuery('SELECT * FROM $ayatTable WHERE SURANO=$suraNo;');
    var result=await db.query(ayatTable,where: '$columnparaNo= ?',whereArgs: [paraNo]);
    return result.toList();
  }

  static Future<List> getAllSubOjifaFromOjifaTable(int topicno)async{
    Database db=await instance.database;
    var result=await db.query(ojifaTable,where: '$columntopicNo = ? ',whereArgs: [topicno]);
    return result.toList();
  }

  static Future<List> getDuyaNameFromTable()async{
    Database db=await instance.database;
    var result=await db.query(dunaNameTable);
    return result.toList();
  }

  static Future<List> getDuyaDetailsFromTable(String id)async{
    Database db=await instance.database;
    var result=await db.query(duyaDetailsTable,where: '$columndoyaID = ? ',whereArgs: [id]);
    return result.toList();
  }


  static Future<OjifaModels> getAllOjifaFromOjifaTable(int topicno,int subtopicno)async{
    Database db=await instance.database;
    final List<Map<String,dynamic>> result=await db.query(ojifaTable,where: '$columntopicNo = ? AND $columnsubtopicNo = ? ',whereArgs: [topicno,subtopicno]);
    if(result.length>0){
      return OjifaModels.fromMap(result.first);
    }
    return null;
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

  static Future<PrayerTimeModels> getPrayerTimeModels(String date)async{
    Database db=await instance.database;
    final List<Map<String,dynamic>> prayerTimes=await db.query(prayerTimeTable,where: '$columndate = ? ',whereArgs: [date]);
    if(prayerTimes.length>0){
      return PrayerTimeModels.frommap(prayerTimes.first);
    }
    return null;
  }

}