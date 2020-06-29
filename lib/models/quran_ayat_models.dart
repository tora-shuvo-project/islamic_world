
import 'package:searchtosu/models/quran_sura_models.dart';

final String TABLE_QURAN_AYAT='tbl_quran_ayat';
final String COL_ARABIQURAN='col_arabi_quran';
final String COL_BANGLA_MEANING_AYAT='col_bangla_meaning';
final String COL_BANGLA_TRANSLATOR_AYAT='col_bangla_translator';

class QuranAyatModels{
  int suraNo;
  int ayatNo;
  String arabiQuran;
  String banglaMeaning;
  String banglaTranslator;

  QuranAyatModels({
      this.suraNo,
      this.ayatNo,
      this.arabiQuran,
      this.banglaMeaning,
      this.banglaTranslator,});


  Map<String,dynamic> toMap(){
    final map=<String,dynamic>{
      COL_SURA_NO:suraNo,
      COL_ARABIQURAN:arabiQuran,
      COL_BANGLA_MEANING:banglaMeaning,
      COL_BANGLA_TRANSLATOR:banglaTranslator,
    };

    if(ayatNo!=null){
      map[COL_Ayat_NO]=ayatNo;
    }
    return map;
  }

  QuranAyatModels.fromMap(Map<String,dynamic> map){
    suraNo=map[COL_SURA_NO];
    ayatNo=map[COL_Ayat_NO];
    arabiQuran=map[COL_ARABIQURAN];
    banglaMeaning=map[COL_BANGLA_MEANING];
    banglaTranslator=map[COL_BANGLA_TRANSLATOR];
  }

  @override
  String toString() {
    return 'QuranAyatModels{suraNo: $suraNo, ayatNo: $ayatNo, arabiQuran: $arabiQuran, banglaMeaning: $banglaMeaning, banglaTranslator: $banglaTranslator}';
  }
}