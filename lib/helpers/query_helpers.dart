import 'package:searchtosu/helpers/db_helpers.dart';
import 'package:searchtosu/models/quran_sura_models.dart';
import 'package:sqflite/sqflite.dart';

class QueryHelpers{

  static Future<int> insertquransura(String table,Map<String,dynamic> map)async{
    final db=await DBHelpers.open();
    return db.insert(table, map,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<QuranSuraModels>> getAllQuranSuraName()async{
    final db=await DBHelpers.open();
    final List<Map<String,dynamic>> map=await db.query(DBHelpers.CREATE_TABLE_QURAN_SURA,orderBy: COL_SURA_NO);
    return List.generate(map.length, (index){
      return QuranSuraModels.formModels(map[index]);
    });
  }

}