class NiyomModels{
  int category,sub_category;
  String name,description;

  NiyomModels(this.category, this.sub_category, this.name, this.description);

  NiyomModels.fromMap(dynamic map){
    this.category=map['CATEGORY'];
    this.sub_category=map['SUB_CATEGORY'];
    this.name=map['NAME'];
    this.description=map['DESCRIPTIONN'];
  }
}