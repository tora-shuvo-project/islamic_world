import 'package:searchtosu/helpers/db_helpers.dart';
import 'package:searchtosu/models/quran_ayat_models.dart';
import 'package:searchtosu/models/quran_sura_models.dart';
import 'package:sqflite/sqflite.dart';

class QueryHelpers{

  static Future<int> insertquransura(String table,Map<String,dynamic> map)async{
    final db=await DBHelpers.open();
    return await db.insert(table, map,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<QuranSuraModels>> getAllQuranSuraName()async{
    final db=await DBHelpers.open();
    final List<Map<String,dynamic>> map=await db.query(TABLE_SURA_MODELS,orderBy: COL_SURA_NO);
    return List.generate(map.length, (index){
      return QuranSuraModels.formModels(map[index]);
    });
  }

  static Future<int> insertQuranSuraDetails(String table,Map<String,dynamic> map)async{
    final db=await DBHelpers.open();
    return await db.insert(table, map,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<QuranAyatModels>> getallSuraDetails()async{
    final db=await DBHelpers.open();
    final List<Map<String,dynamic>> map=await db.query(TABLE_QURAN_AYAT,orderBy: COL_SURA_NO);
    return List.generate(map.length, (index) {
      return QuranAyatModels.fromMap(map[index]);
    });
  }

}