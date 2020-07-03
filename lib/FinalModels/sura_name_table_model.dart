class SuraNameTableModel{
  String ayatNo,paraNumber,arbiSuraNam,banglaMeaning,banglaTranslator,obotirno,englishSuraname;
  int suraNo;

  SuraNameTableModel();

  Map<String,dynamic> tomap(){
    var map=new Map<String,dynamic>();
    map['AYATNO']=ayatNo;
    map['SURANO']=suraNo;
    map['PARANUMBER']=paraNumber;
    map['ARBISURANAME']=arbiSuraNam;
    map['BANGLAMEANING']=banglaMeaning;
    map['BANGLATRANSLATOR']=banglaTranslator;
    map['OBOTIRNO']=obotirno;
    map['ENGLISHSURANAME']=englishSuraname;
  }

  SuraNameTableModel.formMap(dynamic map){
    this.ayatNo=map['AYATNO'];
    this.suraNo=map['SURANO'];
    this.paraNumber=map['PARANUMBER'];
    this.arbiSuraNam=map['ARBISURANAME'];
    this.banglaMeaning=map['BANGLAMEANING'];
    this.banglaTranslator=map['BANGLATRANSLATOR'];
    this.obotirno=map['OBOTIRNO'];
    this.englishSuraname=map['ENGLISHSURANAME'];
  }
}