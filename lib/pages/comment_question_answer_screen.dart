import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchtosu/FinalModels/comment_feedback_models.dart';
import 'package:searchtosu/FinalModels/comment_models.dart';
import 'package:searchtosu/Widgets/custome_buttom_sheet.dart';
import 'package:searchtosu/helpers/firestore_database_helper.dart';
import 'package:share/share.dart';

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
            tooltip: 'Share',
            onPressed: (){
              setState(() {
                //Clipboard.setData(ClipboardData(text: 'Shuvo'));
                Share.share('বিভাগঃ ${widget.commentModels.category}\nসময়ঃ ${widget.commentModels.date}\nপ্রশ্নঃ ${widget.commentModels.question} Show Answer Check Islamic World Android Application');

              });
            },
          ),

          FlatButton.icon(onPressed: (){

            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context)=>SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: CustomeButtomSheet(widget.commentModels.id),
                  ),
                ));
          },
              icon: Icon(Icons.comment,color: Colors.white,),
              label: Text('Comment',
                style: TextStyle(color: Colors.white,fontSize: 14),)),

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

          Card(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('বিভাগঃ ${widget.commentModels.category}',style: TextStyle(
                      fontSize: 16,
                    ),),
                    Text('সময়ঃ ${widget.commentModels.date}',style: TextStyle(
                      fontSize: 14,
                    ),)
                  ],
                )),
          ),

          SizedBox(height: 10,),
          Text('Answer Section:',style:
          TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monserat',

          ),),
          SizedBox(height: 10,),


        Expanded(
          child: Center(
            child:
            FutureBuilder(
              future: FirestoreDatabaseHelper.getAllReplySpecifyQuestion(widget.commentModels.id),
              builder: (context,AsyncSnapshot<List<ComentFeedBackModels>> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                        if(index<0){
                          return Text('No Answer');
                        }else{
                          return Card(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('উত্তর কারীর নামঃ ${snapshot.data[index].answername}',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text('উত্তর দেওয়ার সময়ঃ ${snapshot.data[index].date}',style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),),
                                  Text('উত্তরঃ ${snapshot.data[index].answer}',style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),),

                                ],
                              ),
                            )
                          );
                        }
                      });
                }
                if(snapshot.hasError){
                  return Text('Data Fetch a Problems');
                }
                return CircularProgressIndicator(backgroundColor: Colors.green,);
              },
            ),
          ),
        ),

//          widget.commentModels.commentFeedbackModels==null?
//          Container(
//            child: Text('No Answer Found'),
//          ):


        ],
      ),
    );
  }
}
