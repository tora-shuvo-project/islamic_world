class DoyaNameModels{


  int globalId,category,duaId;
  String name,id;

  DoyaNameModels({this.globalId, this.category, this.duaId, this.name, this.id});

  DoyaNameModels.fromMap(dynamic map){
    this.globalId=map['GLOBAL_ID'];
    this.category=map['CATEGORY'];
    this.duaId=map['DUYA_ID'];
    this.name=map['NAME'];
    this.id=map['ID'];
  }
}