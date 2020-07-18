class ComentFeedBackModels{
  String answername,answer;

  ComentFeedBackModels({this.answername, this.answer});

  Map<String,dynamic> tomap(){
    var map=<String,dynamic>{
      'ansername':answername,
      'answer':answer
    };
    return map;
  }

  ComentFeedBackModels.fromMap(Map<String,dynamic> map){
    answername=map['ansername'];
    answer=map['answer'];
  }
}