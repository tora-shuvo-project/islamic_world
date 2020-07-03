import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class AyatTableDBHelper{
    static final databaseName='ISLAM.db';
    static final databaseVersion=1;
    static final ayat_table_name='AyatTbl';
    static final SuraNoColumn='SURANO';
    static final AyatNOColumn='AYATNO';
    static final ArabiQuranColumn='ARABIQURAN';
    static final BanglaMeaningColumn='BANGLAMEANING';
    static final BanglaTranslatorColumn='BANGLATRANSLATOR';
    static final SejdaColumn='SEJDA';


    AyatTableDBHelper._privateConstrator();
    static final AyatTableDBHelper instance=AyatTableDBHelper._privateConstrator();

    static Database _database;
    Future<Database> get database async{
        if(_database!=null)return _database;
        _database=await _initAyatTableDatabase();
        return _database;
    }

  _initAyatTableDatabase() async{
      var databasePath=await getDatabasesPath();
      String path=join(databasePath,databaseName);

      var exists=await databaseExists(path);
      if(!exists){
          print('Copy Ayat table Database Start');

          try{
              await Directory(dirname(path)).create(recursive: true);
          }catch(_){}

          ByteData data=await rootBundle.load(join("assets",databaseName));
          List<int> bytes=data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

          //write
          await File(path).writeAsBytes(bytes,flush: true);

      }else{
          print('Opening Ayat table existing database');
      }
      return await openDatabase(path,version: databaseVersion);
  }
    // Insert AyatFromAyatTable
    Future<int> insertAyatFromAyatTable(Map<String,dynamic> row)async{
        Database db=await instance.database;
        return await db.insert(ayat_table_name, row,nullColumnHack: null);
    }
// getting ayat
    Future<List> getAllAyatFromAyatTable()async{
        Database db=await instance.database;
        var result=await db.query(ayat_table_name);
        return result.toList();
    }




}