import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/comment_models.dart';

class CommentQuestionAnswerScreen extends StatefulWidget {

  final CommentModels commentModels;
  CommentQuestionAnswerScreen(this.commentModels);

  @override
  _CommentQuestionAnswerScreenState createState() => _CommentQuestionAnswerScreenState();
}

class _CommentQuestionAnswerScreenState extends State<CommentQuestionAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.commentModels.category}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share,color: Colors.white,),
            onPressed: (){

            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Text('প্রশ্নঃ ${widget.commentModels.question}',style: TextStyle(
                  fontSize: 16,
                ),)),
          ),

          SizedBox(height: 10,),
          Text('Answer Section:',style:
          TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monserat',

          ),),
          SizedBox(height: 10,),
          widget.commentModels.commentFeedbackModels==null?
          Container(
            child: Text('No Answer Found'),
          ):ListView.builder(
              itemCount: widget.commentModels.commentFeedbackModels.length,
              itemBuilder: (context,index){
                if(index<0){
                  return Text('No Answer');
                }else{
                  return Card(
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.share),
                        onPressed: (){

                        },
                      ),
                      title: Text('উত্তর কারীর নামঃ ${widget.commentModels.commentFeedbackModels[index].answername}'),
                      subtitle: Text('উত্তরঃ ${widget.commentModels.commentFeedbackModels[index].answer}'),
                    ),
                  );
                }
              }),

        ],
      ),
    );
  }
}
