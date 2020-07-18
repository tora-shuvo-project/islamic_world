class ComentFeedBackModels{
  String answername,answer,id,date,dateKey;


  ComentFeedBackModels({this.answername, this.answer, this.id, this.date,this.dateKey});

  Map<String,dynamic> tomap(){
    var map=<String,dynamic>{
      'ansername':answername,
      'answer':answer,
      'id':id,
      'date':date,
      'datekey':dateKey,
    };
    return map;
  }

  ComentFeedBackModels.fromMap(Map<String,dynamic> map){
    answername=map['ansername'];
    answer=map['answer'];
    id=map['id'];
    date=map['date'];
    dateKey=map['datekey'];
  }
}