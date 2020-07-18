import 'package:searchtosu/FinalModels/comment_feedback_models.dart';

class CommentModels{
  String id,category,question,date,name;
  int seen;


  CommentModels({this.id, this.category, this.question, this.date, this.seen, this.name});

  Map<String,dynamic> tomap(){
    final map=<String,dynamic>{
      'id':id,
      'category':category,
      'question':question,
      'date':date,
      'seen':seen,
      'questiarname':name,
    };
    return map;
  }

  CommentModels.fromMap(Map<String,dynamic> map){
    id=map['id'];
    category=map['category'];
    question=map['question'];
    date=map['date'];
    seen=map['seen'];
    name=map['questiarname'];
  }

}