class DoyaDetailsModels{

  int sl_no,global_id;
  String id,arabic,bangla_meaning,banglaTranslator,niyom,reference;

  DoyaDetailsModels({this.id, this.sl_no, this.global_id, this.arabic,
      this.bangla_meaning, this.banglaTranslator, this.niyom, this.reference});

  DoyaDetailsModels.fromMap(dynamic map){
    this.id=map['ID'];
    this.sl_no=map['SL_NO'];
    this.global_id=map['GLOBAL_ID'];
    this.arabic=map['ARABIC'];
    this.bangla_meaning=map['BANGLA_MEANING'];
    this.banglaTranslator=map['BANGLA_TRANSLATOR'];
    this.niyom=map['NIYOM'];
    this.reference=map['REFERENCE'];
  }
}