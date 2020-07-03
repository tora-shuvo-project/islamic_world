class AyatTableModel{
  String arbiQuran,banglameaning,banglaTranslator,sejda;
  int ayatno,surano;

  AyatTableModel();

  Map<String,dynamic> tomap(){
    var map=new Map<String,dynamic>();
    map['AYATNO']=ayatno;
    map['SURANO']=surano;
    map['ARABIQURAN']=arbiQuran;
    map['BANGLAMEANING']=banglameaning;
    map['BANGLATRANSLATOR']=banglaTranslator;
    map['SEJDA']=sejda;
  }

  AyatTableModel.formMap(dynamic map){
    this.ayatno=map['AYATNO'];
    this.surano=map['SURANO'];
    this.arbiQuran=map['ARABIQURAN'];
    this.banglameaning=map['BANGLAMEANING'];
    this.banglaTranslator=map['BANGLATRANSLATOR'];
    this.sejda=map['SEJDA'];
  }
}