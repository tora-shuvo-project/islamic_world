
final String TABLE_SURA_MODELS='sura_models';

final String COL_SURA_NO='col_suraNo';
final String COL_Ayat_NO='col_ayatNo';
final String COL_PARA_NO='col_paraNO';
final String COL_ARABIA_SURA_NAME='col_arabia_sura_name';
final String COL_BANGLA_MEANING='col_bangla_meaning';
final String COL_BANGLA_TRANSLATOR='col_bangla_translator';
final String COL_OBOTIRNO='col_obotirno';
final String COL_RUKU_NO='col_ruku_no';
final String COL_ENGLISH_SURA_NAME='col_english_sura_name';

class QuranSuraModels{

  int suraNo;
  int ayatNo;
  String paraNo;
  String arabisuraName;
  String banglaMeaning;
  String banglaTranslator;
  String obotirno;
  String rukuNo;
  String englishSuraName;

  Map<String,dynamic> tomap(){
    final map=<String,dynamic>{
      COL_SURA_NO:suraNo,
      COL_Ayat_NO:ayatNo,
      COL_PARA_NO:paraNo,
      COL_ARABIA_SURA_NAME:arabisuraName,
      COL_BANGLA_MEANING:banglaMeaning,
      COL_BANGLA_TRANSLATOR:banglaTranslator,
      COL_OBOTIRNO:obotirno,
      COL_RUKU_NO:rukuNo,
      COL_ENGLISH_SURA_NAME:englishSuraName,
    };
    return map;
  }

  QuranSuraModels.formModels(Map<String,dynamic> map){
    suraNo=map[COL_SURA_NO];
    ayatNo=map[COL_Ayat_NO];
    paraNo=map[COL_PARA_NO];
    arabisuraName=map[COL_ARABIA_SURA_NAME];
    banglaMeaning=map[COL_BANGLA_MEANING];
    banglaTranslator=map[COL_BANGLA_TRANSLATOR];
    obotirno=map[COL_OBOTIRNO];
    rukuNo=map[COL_RUKU_NO];
    englishSuraName=map[COL_ENGLISH_SURA_NAME];
  }

  @override
  String toString() {
    return 'QuranSuraModels{suraNo: $suraNo, ayatNo: $ayatNo, paraNo: $paraNo, arabisuraName: $arabisuraName, banglaMeaning: $banglaMeaning, banglaTranslator: $banglaTranslator, obotirno: $obotirno, rukuNo: $rukuNo, englishSuraName: $englishSuraName}';
  }
}