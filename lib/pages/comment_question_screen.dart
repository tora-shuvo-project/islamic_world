import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/comment_models.dart';
import 'package:searchtosu/helpers/firestore_database_helper.dart';
import 'package:searchtosu/pages/comment_add_Pages.dart';
import 'package:searchtosu/pages/comment_question_answer_screen.dart';

class CommentQuestionScreen extends StatefulWidget {
  @override
  _CommentQuestionScreenState createState() => _CommentQuestionScreenState();
}

class _CommentQuestionScreenState extends State<CommentQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>CommentAddPages()
              )).then((_){
                setState(() {

                });
              });
            },
            tooltip: 'Add Question',
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: FirestoreDatabaseHelper.getAllCommentModels(),
          builder: (context,AsyncSnapshot<List<CommentModels>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: InkWell(
                        onTap: (){

                          CommentModels commentModels=CommentModels();
                          commentModels.seen=snapshot.data[index].seen+1;
                          commentModels.id=snapshot.data[index].id;
                          commentModels.name=snapshot.data[index].name;
                          commentModels.date=snapshot.data[index].date;
                          commentModels.category=snapshot.data[index].category;
                          commentModels.question=snapshot.data[index].question;

                          FirestoreDatabaseHelper.UpdateFeedBack(commentModels).then((value){
                            setState(() {
                              print('update Sussessfull');
                            });
                          });

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>CommentQuestionAnswerScreen( snapshot.data[index],)
                          )).then((value){
                            setState(() {

                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(flex:2,child: Text('বিভাগঃ ${snapshot.data[index].category}')),
                                  Expanded(child: FittedBox(child: Text('Dt: ${snapshot.data[index].date}')))
                                ],
                              ),
                              Text('প্রশ্নঃ ${snapshot.data[index].question}',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('দেখা হয়েছেঃ ${snapshot.data[index].seen} বার')
                                ],
                              ),
                              Text('প্রশ্নকারীর নামঃ ${snapshot.data[index].name}')
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            if(snapshot.hasError){
              return Text('Data Fetch a Problems');
            }
            return CircularProgressIndicator(backgroundColor: Colors.green,);
          },
        ),
      ),
    );
  }
}
