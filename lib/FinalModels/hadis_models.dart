class HadisModels{
  int hadisNo;
  String arabyHadis,banglaMeaning;

  HadisModels({this.hadisNo, this.arabyHadis, this.banglaMeaning});

  HadisModels.frommap(dynamic map){
    this.hadisNo=map['NO'];
    this.arabyHadis=map['ARABI'];
    this.banglaMeaning=map['BANGLA_MEANING'];
  }
}