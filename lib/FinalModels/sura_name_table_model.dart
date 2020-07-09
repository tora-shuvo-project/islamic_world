class SuraNameTableModel{
  String ayatNo,paraNumber,arbiSuraNam,banglaMeaning,banglaTranslator,obotirno,englishSuraname,keyName;
  int suraNo;

  SuraNameTableModel();

  Map<String,dynamic> tomap(){
    var map=new Map<String,dynamic>();
    map['AYATNO']=ayatNo;
    map['SURANO']=suraNo;
    map['PARANO']=paraNumber;
    map['ARABISURANAME']=arbiSuraNam;
    map['BANGLAMEANING']=banglaMeaning;
    map['BANGLATRANSLATOR']=banglaTranslator;
    map['OBOTIRNO']=obotirno;
    map['ENGLISHSURANAME']=englishSuraname;
    map['KEYNAME']=keyName;
  }

  SuraNameTableModel.formMap(dynamic map){
    this.ayatNo=map['AYATNO'];
    this.suraNo=map['SURANO'];
    this.paraNumber=map['PARANO'];
    this.arbiSuraNam=map['ARABISURANAME'];
    this.banglaMeaning=map['BANGLAMEANING'];
    this.banglaTranslator=map['BANGLATRANSLATOR'];
    this.obotirno=map['OBOTIRNO'];
    this.englishSuraname=map['ENGLISHSURANAME'];
    this.keyName=map['KEYNAME'];
  }
}