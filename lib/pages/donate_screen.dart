import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchtosu/pages/home_screen.dart';
import 'package:toast/toast.dart';

class DonateScreen extends StatefulWidget {

  static final route='/donate';

  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {

  bool isExpanded1=true;
  bool isExpanded2=true;
  bool isExpanded3=true;
  bool isQuestion=true;

  TextStyle contentTextStyle=TextStyle(
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      },
      child: Scaffold(
        body: SafeArea(
          child:ListView(
            children: <Widget>[
              Container(
                color: Colors.green,
                padding: EdgeInsets.all(8),
                child: Text('সাদাকায়ে জারিয়ার এই কাজে "সার্চ ইসলাম" মোবাইল আপ্লিকেশন এর সাথে থাকুন।',style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.green.withOpacity(.4),
                      child: FlatButton(
                        child: Text('প্রশ্ন ও উত্তর',style: TextStyle(
                          fontSize: 16
                        ),),
                        onPressed: (){
                          setState(() {
                            isQuestion=true;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green.withOpacity(.6),
                      child: FlatButton(
                        child: Text('পেমেন্ট করুন',style: TextStyle(
                            fontSize: 16
                        )),
                        onPressed: (){
                          setState(() {
                            isQuestion=false;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              isQuestion?
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text('আস-সালামু আলাইকুম ওয়া রাহতুল্লাহি ওয়া বারকাতুহু,\n'
                          'সমস্ত প্রশংসা একমাত্র আল্লাহ তায়ালার জন্য, দরূদ ও সালাম মহানবী হযরত মুহাম্মাদ (সা.) এর উপর পেশ করছি, অতঃপর -',style: TextStyle(
                        fontSize: 17
                      ),),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.all(4),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                isExpanded1=!isExpanded1;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(child: Text('“সার্চ ইসলাম” মোবাইল আপ্লিকেশন সম্পর্কে সংক্ষেপে কিছু কথা আপনাদের উদ্দেশ্য,',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                ),)),
                                IconButton(
                                  icon: Icon(isExpanded1?Icons.arrow_downward:Icons.close,color: Colors.white,),
                                  onPressed: (){
                                    setState(() {
                                      isExpanded1=!isExpanded1;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        isExpanded1?Container():
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text("আলহামদুলিল্লাহ্, “সার্চ ইসলাম”  এই প্রজেক্ট বিগত ২০ ই মে ২০২০ সালের  কার্যক্রম শুরু করেছি এবং এটি সম্পূর্ণ ব্যাক্তি উদ্যোগে পরিচালিত। এই প্রজেক্টের সাথে কোন ধরনের দল, গ্রুপ বা সংগঠনের সম্পৃক্ততা নেই এবং আমরা এগুলি থেকে মুক্ত, আলহামদুলিল্লাহ্ এবং ভবিষ্যতেও যেন মুক্ত থাকতে পারি আল্লাহর কাছে সেই দুয়া করি সব সময়।আপনাদের সহযোগিতা দ্বীনের এই কাজকে আরও ত্বরান্বিত করবে ইন-শা-আল্লাহ।",style: contentTextStyle,),
                        )
                      ],
                    ),

                    Divider(),
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)
                        ),
                          padding: EdgeInsets.all(4),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                isExpanded2=!isExpanded2;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(child: Text('আমাদের উদ্দেশ্য',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                ),)),
                                IconButton(
                                  icon: Icon(isExpanded2?Icons.arrow_downward:Icons.close,color: Colors.white,),
                                  onPressed: (){
                                    setState(() {
                                      isExpanded2=!isExpanded2;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        isExpanded2?Container():
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(' আমাদের একমাত্র উদ্দেশ্য বাংলা ভাষী মানুষের কাছে সঠিক ইসলামকে তুলে ধরা এই আপ্লিকেশন মাধ্যমে, যেন সবাই বিশুদ্ধ ভাবে  ইসলামকে জানতে, বুঝতে ও তা গ্রহন করতে পারে।  আর এই কাজের মাধ্যমে আমরা শুধু একমাত্র আল্লাহর সন্তোষটি অর্জন করতে চাই। দুয়া করি তিনি যেন আমাদের এই ক্ষুদ্র প্রচেষ্টাকে কবুল করেন এবং এর উসিলায় সকলকে হেদায়েত দান করেন এবং ফলাফল হিসাবে জান্নাতুল ফিরদাউস দান করেন। আল্লাহ্ আমাদের সকলকে কবুল করুন। আমীন।আমাদের উদ্দেশ্য এই নয় যে আমরা এই প্রজেক্টের মাধ্যমে টাকা আয় করব আর তা দিয়ে নিজেরা বাড়ি, গাড়ি ইত্যাদি তৈরি করব দুনিয়ার সম্পদ, সম্মান অর্জন করব। আমাদের একমাত্র উদ্দেশ্য আল্লাহর দ্বীন প্রচার এবং এর মাধ্যমে আল্লাহর সন্তোষটি অর্জনের প্রচেষ্টা।',style: contentTextStyle,),
                        )
                      ],
                    ),
                    Divider(),
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.all(4),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                isExpanded3=!isExpanded3;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(child: Text('অন্য অ্যাাপে ডোনেশন চায় না এখানে কেন চায়?',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                ),)),
                                IconButton(
                                  icon: Icon(isExpanded3?Icons.arrow_downward:Icons.close,color: Colors.white,),
                                  onPressed: (){
                                    setState(() {
                                      isExpanded3=!isExpanded3;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        isExpanded3?Container():
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text('মোবাইল আপ্লিকেশন থেকে অর্থ ইনকামের একমাত্র রাস্তা হচ্ছে গুগলের/ফেছবুকের বিজ্ঞাপন দেখানো।অ্যাাপ ডাউনলোড বা ব্যাবহারে করলে ডেভেলপাররা কোন টাকা পায় না একমাত্র বিজ্ঞাপন দেখালেই টাকা পাওয়া যায়।কিন্তু বিজ্ঞাপন দেখানোর মাধ্যমে পর্দার বিধান লঙ্ঘন হওয়ার আশংকায় আমরা উপার্জনের এই একটি মাত্রপথ তা বন্ধ করে দিয়েছি।তাই এই আপ্লিকেশন উত্তরোত্তর আধুনিকায়ন ও মেইনটেনেন্সের জন্য সাহায্য করতে চাইলে অনুদান দিতে পারেন। ',style: contentTextStyle,),
                        )
                      ],
                    ),

                  ],
                ),
              ):
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:EdgeInsets.all(8),
                      child: Text('নিচের অপশনগুলোর মাধ্যমে এই অ্যাাপের জন্য প্রতি মাসে আর্থিক অনুদান পাঠাতে পারেন।',style: TextStyle(
                        fontSize: 18
                      ),),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('bkash',style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),),
                        subtitle: Text('Account Number: 010219210212\nAccount Type: Personal'),
                        trailing: IconButton(
                          icon: Icon(Icons.content_copy),
                          onPressed: (){
                            Toast.show('Copy Sussessfull', context);
                            Clipboard.setData(ClipboardData(text: '01812812811121'));
                          },
                        ),
                      ),
                    ),

                    Card(
                      child: ListTile(
                        title: Text('Rocket'),
                        subtitle: Text('Account Number: 010219210212\nAccount Type: Personal'),
                        trailing: IconButton(
                          icon: Icon(Icons.content_copy),
                          onPressed: (){
                            Toast.show('Copy Sussessfull', context);
                            Clipboard.setData(ClipboardData(text: '01812812811121'));
                          },
                        ),
                      ),
                    ),

                    Card(
                      child: ListTile(
                        title: Text('Sure Cash'),
                        subtitle: Text('Account Number: 010219210212\nAccount Type: Personal'),
                        trailing: IconButton(
                          icon: Icon(Icons.content_copy),
                          onPressed: (){
                            Toast.show('Copy Sussessfull', context);
                            Clipboard.setData(ClipboardData(text: '01812812811121'));
                          },
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
