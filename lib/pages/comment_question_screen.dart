import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/comment_models.dart';
import 'package:searchtosu/helpers/firestore_database_helper.dart';
import 'package:searchtosu/pages/comment_add_Pages.dart';
import 'package:searchtosu/pages/comment_question_answer_screen.dart';
import 'package:searchtosu/pages/home_screen.dart';

class CommentQuestionScreen extends StatefulWidget {
  @override
  _CommentQuestionScreenState createState() => _CommentQuestionScreenState();
}

class _CommentQuestionScreenState extends State<CommentQuestionScreen> {

  List<CommentModels> comentModels=new List();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    FirestoreDatabaseHelper.getAllCommentModels().then((value){
      for(int i=value.length-1;i>=0;i--){
        setState(() {
          comentModels.add(value[i]);
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Question'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>CommentAddPages()
                ));
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
                    itemCount: comentModels.length,
                    dragStartBehavior: DragStartBehavior.start,
                    itemBuilder: (context,index){
                      return Card(
                        child: InkWell(
                          onTap: (){

                            print(comentModels[index].id);
                            CommentModels commentModels=CommentModels();
                            commentModels.seen=comentModels[index].seen+1;
                            commentModels.id=comentModels[index].id;
                            commentModels.name=comentModels[index].name;
                            commentModels.date=comentModels[index].date;
                            commentModels.category=comentModels[index].category;
                            commentModels.question=comentModels[index].question;

                            FirestoreDatabaseHelper.UpdateFeedBack(commentModels).then((value){
                              setState(() {
                                print('update Sussessfull');
                              });
                            });

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>CommentQuestionAnswerScreen( comentModels[index],)
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
                                    Expanded(flex:2,child: Text('বিভাগঃ ${comentModels[index].category}')),
                                    Expanded(child: FittedBox(child: Text('Dt: ${comentModels[index].date}')))
                                  ],
                                ),
                                Text('প্রশ্নঃ ${comentModels[index].question}',style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('দেখা হয়েছেঃ ${comentModels[index].seen} বার',style: TextStyle(
                                      color: Colors.green
                                    ),)
                                  ],
                                ),
                                Text('প্রশ্নকারীর নামঃ ${comentModels[index].name}',style: TextStyle(
                                  color: Colors.pink
                                ),)
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
      ),
    );
  }
}
