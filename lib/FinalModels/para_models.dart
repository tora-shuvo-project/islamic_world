class ParaModels{
  int paraNo;
  String nameArabi,nameEnglish,nameBangla;
  String audio_sudais,audio_gumadi,audio_budair,audio_alajmi,audio_mishary;

  ParaModels({this.paraNo, this.nameArabi, this.nameEnglish, this.nameBangla,
      this.audio_sudais});

  ParaModels.fromMap(dynamic map){
    this.paraNo=map['PARANO'];
    this.nameArabi=map['NAME_ARABI'];
    this.nameEnglish=map['NAME_ENGLISH'];
    this.nameBangla=map['NAME_BANGLA'];
    this.audio_sudais=map['AUDIO_SUDAIS'];
    this.audio_gumadi=map['SAD_AL_GUAMIDI'];
    this.audio_budair=map['SALAH_BUDIR'];
    this.audio_alajmi=map['AHMED_AL_AJMI'];
    this.audio_mishary=map['MISHARY'];
  }

}