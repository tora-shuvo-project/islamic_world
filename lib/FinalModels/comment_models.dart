import 'package:searchtosu/FinalModels/comment_feedback_models.dart';

class CommentModels{
  String id,category,question,date,name;
  int seen;
  List<ComentFeedBackModels> commentFeedbackModels;


  CommentModels({this.id, this.category, this.question, this.date, this.seen,
      this.commentFeedbackModels,this.name});

  Map<String,dynamic> tomap(){
    var map=<String,dynamic>{
      'id':id,
      'category':category,
      'question':question,
      'date':date,
      'seen':seen,
      'answer':commentFeedbackModels,
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
    commentFeedbackModels=map['answer'];
    name=map['questiarname'];
  }

}