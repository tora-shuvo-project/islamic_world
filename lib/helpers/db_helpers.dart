import 'package:searchtosu/models/quran_ayat_models.dart';
import 'package:searchtosu/models/quran_mp3_models.dart';
import 'package:searchtosu/models/quran_sura_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class DBHelpers{

  static final String CREATE_TABLE_QURAN_SURA='''create table $TABLE_SURA_MODELS(
  $COL_SURA_NO integer primary key,
  $COL_Ayat_NO integer not null,
  $COL_PARA_NO text not null,
  $COL_ARABIA_SURA_NAME text not null,
  $COL_BANGLA_MEANING text not null,
  $COL_BANGLA_TRANSLATOR text not null,
  $COL_OBOTIRNO text not null,
  $COL_RUKU_NO text not null,
  $COL_ENGLISH_SURA_NAME text not null)''';

  static final String CREATE_TABLE_QURAN_AYAT='''create table $TABLE_QURAN_AYAT (
  $COL_SURA_NO integer primary key,
  $COL_Ayat_NO integer autoincrement,
  $COL_ARABIQURAN text not null,
  $COL_BANGLA_MEANING_AYAT text not null,
  $COL_BANGLA_TRANSLATOR_AYAT text not null)''';

  static final String CREATE_TABLE_QURAN_MP3='''create table $TABLE_QURAN_MP3 (
  $COL_SURA_NO integer primary key,
  $COL_PERSON_NAME text not null,
  $COL_PERSON_DESCRIPTION text,
  $COL_MP3_LINK text not null)''';

  static Future<Database> open()async{
    final dbpath=await getDatabasesPath();
    final apath=Path.join(dbpath,'islam.db');
    return openDatabase(apath,version: 1,onCreate: (db,version)async{
      await db.execute(CREATE_TABLE_QURAN_SURA);
      await db.execute(CREATE_TABLE_QURAN_AYAT);
      await db.execute(CREATE_TABLE_QURAN_MP3);
    });
  }

}