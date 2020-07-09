class AyatTableModel{
  String arabi_simple,arabi_utmanic,arbi_indopak,banglameaning,banglaTranslator,sejda,ayatAudio;
  int ayatno,surano,para;

  AyatTableModel();

  Map<String,dynamic> tomap(){
    var map=new Map<String,dynamic>();
    map['AYATNO']=ayatno;
    map['SURANO']=surano;
    map['ARABI_SIMPLE']=arabi_simple;
    map['ARABI_UTMANIC']=arabi_utmanic;
    map['ARABI_INDOPAK']=arbi_indopak;
    map['BANGLA_MUHI']=banglameaning;
    map['BANGLA_TRANSLATOR']=banglaTranslator;
    map['SEJDA']=sejda;
    map['PARA']=para;
    map['AYATAUDIO']=ayatAudio;
  }

  AyatTableModel.formMap(dynamic map){
    this.ayatno=map['AYATNO'];
    this.surano=map['SURANO'];
    this.arabi_simple=map['ARABI_SIMPLE'];
    this.arabi_utmanic=map['ARABI_UTMANIC'];
    this.arbi_indopak=map['ARABI_INDOPAK'];
    this.banglameaning=map['BANGLA_MUHI'];
    this.banglaTranslator=map['BANGLA_TRANSLATOR'];
    this.sejda=map['SEJDA'];
    this.ayatAudio=map['AYATAUDIO'];
    this.para=map['PARA'];
  }
}