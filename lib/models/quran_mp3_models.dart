import 'package:searchtosu/models/quran_sura_models.dart';

final String TABLE_QURAN_MP3='table_quran_mp3';
final String COL_PERSON_NAME='col_person_name';
final String COL_PERSON_DESCRIPTION='col_person_description';
final String COL_MP3_LINK='col_mp3_link';

class QuranMp3Models{
  String suraNo;
  String personName;
  String mp3Link;
  String personDescription;

  QuranMp3Models({
      this.suraNo, this.personName, this.mp3Link, this.personDescription});

  @override
  String toString() {
    return 'QuranMp3Models{suraNo: $suraNo, personName: $personName, mp3Link: $mp3Link, personDescription: $personDescription}';
  }

  Map<String,dynamic> toMap(){
    final map=<String,dynamic>{
      COL_SURA_NO:suraNo,
      COL_PERSON_NAME:personName,
      COL_PERSON_DESCRIPTION:personDescription,
      COL_MP3_LINK:mp3Link,
    };
    return map;
  }

  QuranMp3Models.formMap(Map<String,dynamic> map){
    suraNo=map[COL_SURA_NO];
    personName=map[COL_PERSON_NAME];
    personDescription=map[COL_PERSON_DESCRIPTION];
    mp3Link=map[COL_MP3_LINK];
  }

}