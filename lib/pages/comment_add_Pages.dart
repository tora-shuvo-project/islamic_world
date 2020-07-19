import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchtosu/FinalModels/comment_models.dart';
import 'package:searchtosu/helpers/firestore_database_helper.dart';
import 'package:toast/toast.dart';

class CommentAddPages extends StatefulWidget {
  @override
  _CommentAddPagesState createState() => _CommentAddPagesState();
}

class _CommentAddPagesState extends State<CommentAddPages> {

  final _formKey=GlobalKey<FormState>();
  String _myActivity;
  CommentModels commentModels;
  String date;
  String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentModels=CommentModels();
    _myActivity='';
    DateTime now = DateTime.now();
    date = DateFormat('yyyy-MM-dd hh:mm a').format(now);
    id = DateFormat('yyyy-MM-dd hh:mm:ss a').format(now);
  }


  void _addQuestiontoDatabase() {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      commentModels.date=date;
      commentModels.seen=0;
      commentModels.id=id;

      FirestoreDatabaseHelper.addComment(commentModels).then((_){
        setState(() {
          Toast.show('Question is Added Check Question Screen', context);
          Navigator.of(context).pop();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close,color: Colors.white,),
            tooltip: 'Close Screen',
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'enter your name',
                            border: OutlineInputBorder()
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'name Should not be empty';
                            }
                            return null;
                          },
                          onSaved: (value){
                            commentModels.name=value;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropDownFormField(
                          titleText: 'প্রশ্নের ধরনঃ',
                          hintText: 'choose a category',
                          value: _myActivity,
                          onSaved: (value) async{
                            setState(() {
                              _myActivity = value;
                              commentModels.category=value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _myActivity = value;
                              commentModels.category=value;
                            });
                          },
                          validator: (value){
                            if(value==''){
                              return 'please Select a category';
                            }
                            return null;
                          },
                          dataSource: [
                            {
                              "display": "অর্থনীতি",
                              "value": "অর্থনীতি",
                            },
                            {
                              "display": "অসীলা",
                              "value": "অসীলা",
                            },
                            {
                              "display": "আকীদাহ ও তাওহীদ",
                              "value": "আকীদাহ ও তাওহীদ",
                            },
                            {
                              "display": "আত্তীয়-প্রতিবেশী ও অন্যান্য মানুষ",
                              "value": "আত্তীয়-প্রতিবেশী ও অন্যান্য মানুষ",
                            },
                            {
                              "display": "আদব,শিষ্টাচার ও চরিত্র ",
                              "value": "আদব,শিষ্টাচার ও চরিত্র ",
                            },
                            {
                              "display": "আল্লাহ তাআলা",
                              "value": "আল্লাহ তাআলা",
                            },
                            {
                              "display": "ইবাদত ও আমল ",
                              "value": "ইবাদত ও আমল ",
                            },
                            {
                              "display": "ইসলাম, মুসলিম ও দাওয়াহ",
                              "value": "ইসলাম, মুসলিম ও দাওয়াহ",
                            },
                            {
                              "display": "ইসলামী ইতিহাস ও ঘটনা সমূহ",
                              "value": "ইসলামী ইতিহাস ও ঘটনা সমূহ",
                            },
                            {
                              "display": "ঈমান",
                              "value": "ঈমান",
                            },
                            {
                              "display": "উপহার দেওয়া প্রসঙ্গ",
                              "value": "উপহার দেওয়া প্রসঙ্গ",
                            },
                            {
                              "display": "উপায় বা সমাধান",
                              "value": "উপায় বা সমাধান",
                            },
                            {
                              "display": "কসম ও মান্নত",
                              "value": "কসম ও মান্নত",
                            },
                            {
                              "display": "কাফফারা ",
                              "value": "কাফফারা ",
                            },
                            {
                              "display": "কিয়ামত",
                              "value": "কিয়ামত",
                            },
                            {
                              "display": "কোরআন",
                              "value": "কোরআন",
                            },
                            {
                              "display": "ছাত্র-ছাত্রী",
                              "value": "ছাত্র-ছাত্রী",
                            },
                            {
                              "display": "জান্নাত-জাহান্নাম",
                              "value": "জান্নাত-জাহান্নাম",
                            },
                            {
                              "display": "তাওবা",
                              "value": "তাওবা",
                            },
                            {
                              "display": "দিবস ও উৎসব",
                              "value": "দিবস ও উৎসব",
                            },
                            {
                              "display": "দোয়া ও যিকির",
                              "value": "দোয়া ও যিকির",
                            },
                            {
                              "display": "নারী",
                              "value": "নারী",
                            },
                            {
                              "display": "নাসীহাহ (দ্বীনি পরামর্শ)",
                              "value": "নাসীহাহ (দ্বীনি পরামর্শ)",
                            },
                            {
                              "display": "পবিত্রতা",
                              "value": "পবিত্রতা",
                            },
                            {
                              "display": "পরিধান বস্তু",
                              "value": "পরিধান বস্তু",
                            },
                            {
                              "display": "পরিবার ও দাম্পত্য",
                              "value": "পরিবার ও দাম্পত্য",
                            },
                            {
                              "display": "পানাহার",
                              "value": "পানাহার",
                            },
                            {
                              "display": "পাপ বা গুনাহ",
                              "value": "পাপ বা গুনাহ",
                            },
                            {
                              "display": "পুরুষ",
                              "value": "পুরুষ",
                            },
                            {
                              "display": "প্রচলিত ভুল ও কুসংস্কার",
                              "value": "প্রচলিত ভুল ও কুসংস্কার",
                            },
                            {
                              "display": "ফরজ-ওয়াজিব",
                              "value": "ফরজ-ওয়াজিব",
                            },
                            {
                              "display": "ফিকহ",
                              "value": "ফিকহ",
                            },
                            {
                              "display": "ফিতনা",
                              "value": "ফিতনা",
                            },
                            {
                              "display": "বন্ধুত্ব ও শত্রুতা",
                              "value": "বন্ধুত্ব ও শত্রুতা",
                            },
                            {
                              "display": "বিদ’আত",
                              "value": "বিদ’আত",
                            },
                            {
                              "display": "বিবিধ টিপস",
                              "value": "বিবিধ টিপস",
                            },
                            {
                              "display": "বিবিধ প্রসঙ্গ",
                              "value": "বিবিধ প্রসঙ্গ",
                            },
                            {
                              "display": "বিবিধ বিধি-বিধান",
                              "value": "বিবিধ বিধি-বিধান",
                            },
                            {
                              "display": "মিরাস (সম্পদ বন্টন)",
                              "value": "মিরাস (সম্পদ বন্টন)",
                            },
                            {
                              "display": "মৃত্যু ও মৃত ব্যক্তি",
                              "value": "মৃত্যু ও মৃত ব্যক্তি",
                            },
                            {
                              "display": "যাকাত, ফিতরা ও সাদাকাহ",
                              "value": "যাকাত, ফিতরা ও সাদাকাহ",
                            },
                            {
                              "display": "রোগ ব্যাধি ও চিকিৎসা",
                              "value": "রোগ ব্যাধি ও চিকিৎসা",
                            },
                            {
                              "display": "রোজা ও রমজান",
                              "value": "রোজা ও রমজান",
                            },
                            {
                              "display": "শিরক ও কুফুরী",
                              "value": "শিরক ও কুফুরী",
                            },
                            {
                              "display": "সচেতনতা",
                              "value": "সচেতনতা",
                            },
                            {
                              "display": "সফর",
                              "value": "সফর",
                            },
                            {
                              "display": "সংশয় নিরসন",
                              "value": "সংশয় নিরসন",
                            },
                            {
                              "display": "সালাত",
                              "value": "সালাত",
                            },
                            {
                              "display": "সুন্নাহ",
                              "value": "সুন্নাহ",
                            },
                            {
                              "display": "সুফল-কুফল",
                              "value": "সুফল-কুফল",
                            },
                            {
                              "display": "হজ্জ ও উমরা ",
                              "value": "হজ্জ ও উমরা ",
                            },
                            {
                              "display": "হাদীস",
                              "value": "হাদীস",
                            },
                            {
                              "display": "হালাল-হারাম",
                              "value": "হালাল-হারাম",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'enter your question',
                            border: OutlineInputBorder()
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Question Filed should not be empty';
                            }else if(value.length<10){
                              return 'question field is required minimum 10 charectar long';
                            }
                            return null;
                          },
                          onSaved: (value){
                            commentModels.question=value;
                          },
                          maxLines: null,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 55,
            width: double.infinity,
            color: Colors.green,
            child: FlatButton(
              child: Text('সম্পন্ন করুন',style: TextStyle(color: Colors.white,fontSize: 20),),
              onPressed: (){
                _addQuestiontoDatabase();
              },
            ),
          ),
        ],
      ),
    );
  }

}
