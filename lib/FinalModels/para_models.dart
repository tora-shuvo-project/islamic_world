class ParaModels{
  int paraNo;
  String nameArabi,nameEnglish,nameBangla;
  String audio_sudais;

  ParaModels({this.paraNo, this.nameArabi, this.nameEnglish, this.nameBangla,
      this.audio_sudais});

  ParaModels.fromMap(dynamic map){
    this.paraNo=map['PARANO'];
    this.nameArabi=map['NAME_ARABI'];
    this.nameEnglish=map['NAME_ENGLISH'];
    this.nameBangla=map['NAME_BANGLA'];
    this.audio_sudais=map['AUDIO_SUDAIS'];
  }

}