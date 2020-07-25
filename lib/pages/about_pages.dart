import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPages extends StatefulWidget {
  @override
  _AboutPagesState createState() => _AboutPagesState();
}

class _AboutPagesState extends State<AboutPages> {

  bool isDeveloper=true;
  bool isContact=false;
  bool isHelpUs=false;

  bool isExpanded1=true;
  bool isExpanded2=true;
  bool isExpanded3=true;
  bool isExpanded4=true;

  TextStyle basicStyle=TextStyle(fontSize: 18);
  TextStyle basicStyle2=TextStyle(fontSize: 17);
  TextStyle basicStyle3=TextStyle(fontSize: 15,fontWeight:FontWeight.w500,color: Colors.black);
  TextStyle basicStyle4=TextStyle(fontSize: 17,fontWeight:FontWeight.w600,color: Colors.black);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    } }

  Future<void> _mailto(String email) async{
    final phoneUrl = 'mailto:$email';
    if(await canLaunch(phoneUrl)){
      await launch(phoneUrl);
    }else{
      throw 'Cannot launch phone call';
    }
  }

  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  Future<void> _callNumber(String phoneNumber) async{
    final phoneUrl = 'tel:$phoneNumber';
    if(await canLaunch(phoneUrl)){
      await launch(phoneUrl);
    }else{
      throw 'Cannot launch phone call';
    }
  }
    
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            child: Image.asset('images/notification_icon.png'),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDeveloper&&!isContact&&!isHelpUs?Colors.green.withOpacity(.6):Colors.green.withOpacity(.1)
                    ),
                    child: FlatButton(
                      child: Text('Developer',style: basicStyle3,),
                      onPressed: (){
                        setState(() {
                          isDeveloper=true;
                          isContact=false;
                          isHelpUs=false;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: !isDeveloper&&isContact&&!isHelpUs?Colors.green.withOpacity(.6):Colors.green.withOpacity(.1)
                    ),
                    child: FlatButton(
                      child: Text('Basic Info',style: basicStyle3,),
                      onPressed: (){
                        setState(() {
                          isDeveloper=false;
                          isContact=true;
                          isHelpUs=false;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: !isDeveloper&&!isContact&&isHelpUs?Colors.green.withOpacity(.6):Colors.green.withOpacity(.1)
                    ),
                    child: FlatButton(
                      child: Text('Help Us',style: basicStyle3,),
                      onPressed: (){
                        setState(() {
                          isDeveloper=false;
                          isContact=false;
                          isHelpUs=true;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          isDeveloper&&!isContact&&!isHelpUs?Container(
            child: Column(
              children: <Widget>[
                Card(
                  child: Container(
                    padding: EdgeInsets.only(left: 8,top: 12,bottom: 8,right: 4),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 8,top: 12,bottom: 8,right: 4),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                isExpanded1=!isExpanded1;
                                isExpanded2=true;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Text('মোঃ মেহেদি হাসান শুভ',style: basicStyle,),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        isExpanded1?Container():
                        Row(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                child: Text('About',style: basicStyle2,),
                                onPressed: (){
                                  setState(() {
                                    showModalBottomSheet(context: context,
                                        enableDrag: true,
                                        builder: (BuildContext context){
                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Text('আসসালামুআলাইকুম।আমি মোঃ মেহেদি হাসান শুভ,বরিশাল সরকারী পলিটেকনিক থেকে ডিপ্লোমা ইন ইঞ্জিনিয়ারিং পাশ করে বর্তমানে ঢাকা প্রকৌশল ও প্রযুক্তি বিশ্ববিদ্যালয় এ কম্পিউটার সাইন্স এন্ড ইঞ্জিনিয়ারিং ডিপার্টমেন্ট এ অধ্যায়রত।আমার গ্রামের বাড়ি হচ্ছে কালকিনি,মাদারীপুর। ভাল লাগা থেকেই আমার এই কাজগুলো করা।আসলে অনেক দিন থেকেই এমন একটা জিনিস করার কথা মাথায় ছিল কিন্তু করা হয়ে উঠে নাই,অতঃপর এই করোনা মহামারি মধ্যে সময়টাকে আলহামদুরিয়াল্লাহ পরিপূর্ন ভাবে কাজে লাগাতে পেরেছি। যেহেতু এটা প্রথম ভার্শন তাই কিছু ভুল ভ্রান্তি থাকতেই পারে এর জন্য সকলের কাছে ক্ষমা চাচ্ছি আর ভুলগুলো ধরিয়ে দিতে পারলে অনেক উপকার হত। ভুলগুলো ইমেইল এ পাঠালে ভাল হবে। আমি সংশোধন করার চেষ্টা করব ইন-শা-আল্লাহ।অনেক কিছু এই ইচ্ছা ছিল কিন্তু সব কিছু ইমপ্লিমেন্ট করতে পারি নাই ইন-শা-আল্লাহ খুব তারা তারিই করে ফেলব। সবাই আমার জন্য দোয়া করবেন। যাযাকাল্লাহু খাইর।',style: TextStyle(
                                            fontSize: 18
                                          ),),
                                        ),
                                      );
                                    });
                                  });
                                },
                              ),
                            ),
                            Container(
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    isExpanded2=!isExpanded2;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text('Contact',style: basicStyle2,),
                                    Icon(Icons.keyboard_arrow_down),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        isExpanded2?Container():
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                                onTap:(){
                                  setState(() {
                                    _launchURL('https://web.facebook.com/m.mehedihasanshuvo.in/');
                                  });
                                },
                                child: Image.asset('images/fb.png',width: 40,height: 40,)),

                            InkWell(
                                onTap:(){
                                  setState(() {
                                    _callNumber('01303129515');
                                  });
                                },
                                child: Image.asset('images/call.png',width: 40,height: 40,)),

                            InkWell(
                                onTap:(){
                                  setState(() {
                                    launchWhatsApp(phone: '01303129515',message:'Hello');
                                  });
                                },
                                child: Image.asset('images/whatsapp.png',width: 40,height: 40,)),

                            InkWell(
                                onTap:(){
                                  _mailto('duetinmehedishuvo@gmail.com');
                                },
                                child: Image.asset('images/gmail.png',width: 40,height: 40,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.only(left: 8,top: 12,bottom: 8,right: 4),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 8,top: 12,bottom: 8,right: 4),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                isExpanded3=!isExpanded3;
                                isExpanded4=true;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Text('আদ্রিতা রহমান তরী',style: basicStyle,),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        isExpanded3?Container():
                        Row(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                child: Text('About',style: basicStyle2,),
                                onPressed: (){
                                  setState(() {
                                    showModalBottomSheet(context: context,
                                        enableDrag: true,
                                        builder: (BuildContext context){
                                          return Container(
                                            padding: EdgeInsets.all(8),
                                            child: Text('আমি মোঃ মেহেদি হাসান শুভ ।বর্তমানে ঢাকা প্রকৌশল ও প্রযুক্তি বিশ্ববিদ্যালয় এ কম্পিউটার সাইন্স ডিপার্টমেন্ট এ অধ্যায়রত।',style: TextStyle(
                                                fontSize: 18
                                            ),),
                                          );
                                        });
                                  });
                                },
                              ),
                            ),
                            Container(
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    isExpanded4=!isExpanded4;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text('Contact',style: basicStyle2,),
                                    Icon(Icons.keyboard_arrow_down),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        isExpanded4?Container():
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                                onTap:(){

                                },
                                child: Image.asset('images/fb.png',width: 40,height: 40,)),

                            InkWell(
                                onTap:(){

                                },
                                child: Image.asset('images/call.png',width: 40,height: 40,)),

                            InkWell(
                                onTap:(){

                                },
                                child: Image.asset('images/whatsapp.png',width: 40,height: 40,)),

                            InkWell(
                                onTap:(){

                                },
                                child: Image.asset('images/gmail.png',width: 40,height: 40,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ):Container(),
          !isDeveloper&&isContact&&!isHelpUs?Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Align(
                    alignment:Alignment.center,
                    child: Text('Version: 1',style: basicStyle)),
                Divider(color: Colors.green,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text( 'Featchers:',style: basicStyle2)),
                Divider(),
                Text('1.Read Quran With Audio'
                    '\n2.Prayer Times'
                    '\n3.Quran Word'
                    '\n4.Ojifa'
                    '\n5.Doya'
                    '\n6.Live Comment'
                    '\n7.Nearest Mosque'
                    '\n8.Tasbih'
                    '\n9.Kibla'
                    '\n10.Some Hadis'
                    '\n11.Niyom Kanun'
                    '\n12.Islamic Calender'
                    '\n13.Islamic Blog'
                    '\n14.Prayer time wise Notification'
                    '\n15.5 qare audio voice',style: basicStyle4),

              ],
            ),
          ):Container(),
          !isDeveloper&&!isContact&&isHelpUs?Container(
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/rashedulalam.jacky/');
                  },
                    title: Text('রাসেদুল আলম জ্যাকি'),
                    subtitle: Text('Database Helper'),
                  ),
                ),
                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/hemtarikul/');
                  },
                    title: Text('মোঃ তরিকুল ইসলাম'),
                    subtitle: Text('UI & UX Designer'),
                  ),
                ),
                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/rafatul.islam.549/');
                  },
                    title: Text('মোঃ রাফাতুল ইসলাম'),
                    subtitle: Text('Logo and Splash Designer'),
                  ),
                ),
                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/mdrabiul.islamrabi.71');
                  },
                    title: Text('মোঃ রবিউল ইসলাম'),
                    subtitle: Text('Content Writing'),
                  ),
                ),

                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/hrhany1/');
                  },
                    title: Text('হামিদুর রহমান'),
                    subtitle: Text('Content Writing'),
                  ),
                ),

                Card(
                  child: ListTile(
                    onTap: (){
                      _launchURL('https://web.facebook.com/dada.safwan.948/');
                    },
                    title: Text('মোহাম্মাদ মাঝহার'),
                    subtitle: Text('Content Writing'),
                  ),
                ),

                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/md.mahidi.52/');
                  },
                    title: Text('মোঃ মেহেদি হাসান'),
                    subtitle: Text('Content Writing'),
                  ),
                ),

                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/mdmustafizur.rahman.522');
                  },
                    title: Text('মোঃ মোস্তাফিজুর রহমান তপু'),
                    subtitle: Text('Content Writing'),
                  ),
                ),

                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/younos.duet/');
                  },
                    title: Text('মোঃ ইউনুস'),
                    subtitle: Text('Content Writing'),
                  ),
                ),

                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/mj.naymer');
                  },
                    title: Text('মস্তফা কামাল মুন্না'),
                    subtitle: Text('Content Writing'),
                  ),
                ),

                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/altafmahmud.altafmahmud.92');
                  },
                    title: Text('আলতাফ মাহমুদ'),
                    subtitle: Text('Content Writing'),
                  ),
                ),

                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/profile.php?id=100049340762128');
                  },
                    title: Text('মোঃ আহ্নাফ জাইয়ান'),
                    subtitle: Text('Advisor'),
                  ),
                ),

                Card(
                  child: ListTile(onTap: (){
                    _launchURL('https://web.facebook.com/shaifulislam.shawon.16');
                  },
                    title: Text('মোঃ সাইফুল ইসলাম শাওন'),
                    subtitle: Text('Advisor'),
                  ),
                ),


              ],
            ),
          ):Container()
        ],
      ),
    );
  }
}
