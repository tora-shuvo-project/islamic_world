import 'package:flutter/material.dart';
import 'package:searchtosu/Widgets/SlideAnimation.dart';
import 'package:searchtosu/pages/browser_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPages extends StatefulWidget {
  @override
  _BlogPagesState createState() => _BlogPagesState();
}

class _BlogPagesState extends State<BlogPages> {

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    } }

  @override
  Widget build(BuildContext context) {
    Widget _appBar(){
      return Container(

        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          child: Container(
            height:70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xff178723),
                  const Color(0xff27AB4B)
                ])
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: Container(
              color: Colors.green.withOpacity(.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                    Navigator.of(context).pop();
                  }),
                  FittedBox(
                    child: Text('ইসলামিক ব্লগ',style:  TextStyle(
                        color: Colors.white, fontSize: 20
                    ), ),
                  ),


                ],
              ),
            ),

          ),

        ),
      );
    }
    return SafeArea(
      child: Scaffold(

        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),),
        body: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                onTap: (){
                  _launchURL('http://www.truemuslims.net/Bangla.html');
                },
                leading: Text('1',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('ট্রু মুসলিম',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: English (Audio)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page: BrowserScreen('https://waytotawheed.com/%E0%A6%87%E0%A6%B8%E0%A6%B2%E0%A6%BE%E0%A6%AE%E0%A6%BF%E0%A6%95-%E0%A6%AC%E0%A6%87-%E0%A6%B8%E0%A6%AE%E0%A6%BE%E0%A6%B9%E0%A6%BE%E0%A6%B0/')
                  ));
                  },
                leading: Text('2',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('ওয়ে টু তাওহীদ',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Islamic Books)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page: BrowserScreen('https://alquranbd.com/index.php')
                  ));
                },
                leading: Text('3',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('আল-কুরআন বিডি',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Read Quran)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page: BrowserScreen('http://www.quraanshareef.org/')
                  ));
                },
                leading: Text('4',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('কুরআন-শরিফ',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Read Quran)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page:BrowserScreen('https://deenilhaq.wordpress.com/')
                  ));
                },
                leading: Text('5',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('দীন ইলহক',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Blog)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page:BrowserScreen('https://islamqabd.com/')
                  ));
                },
                leading: Text('6',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('ইসলাম কা বিডি',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Blog & Question)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page: BrowserScreen('https://omukderkotha1.blogspot.com/')
                  ));
                },
                leading: Text('7',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('অমুক দের কথা',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Thesis & Nastik)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  _launchURL('https://www.hadithbd.com/');
                },
                leading: Text('8',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('হাদীদ বিডি',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Hadith)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page: BrowserScreen('https://tablighjammat.wordpress.com/')
                  ));
                },
                leading: Text('9',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('তাবলিক জামাত',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Tabligh)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page:BrowserScreen('https://habibur.com/salat/districts/dhaka/fullyear/')
                  ));
                },
                leading: Text('10',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('হাবিবুর',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: English (Prayer Time)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  _launchURL('http://freequranmp3.com/');
                },
                leading: Text('11',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('ফ্রী কুরআন Mp3',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: English (Audio)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  _launchURL('http://www.houseofquran.com/qsys/quranteacher1.html');
                },
                leading: Text('12',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('হাউস অফ কুরআন',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: English (Web App Quran)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page:BrowserScreen('https://tauheed-sunnat.com/quran-audio-mp3')
                  ));
                },
                leading: Text('13',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('তাওহীদ সুন্নাত',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: English (Audio)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page:BrowserScreen('https://backtojannah.com/')
                  ));
                },
                leading: Text('14',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('বাঁকতও জান্নাহ',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: English (Blog)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page:BrowserScreen('https://islamqa.info/bn')
                  ));
                },
                leading: Text('15',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('ইসলাম কা',style: TextStyle(fontSize: 16),),
                subtitle: Text('type: Bangla (Question)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page:BrowserScreen('https://www.quraneralo.com/')
                  ));
                },
                leading: Text('16',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('কুরআনের আলো',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Blog)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                     page: BrowserScreen('https://amarspondon.wordpress.com/')
                  ));
                },
                leading: Text('17',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('আমার স্পন্ধন',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Blog)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page:BrowserScreen('https://adnanfaisal.wordpress.com/')
                  ));
                },
                leading: Text('18',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('আদনান ফয়সাল',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Blog)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page: BrowserScreen('https://quranerkotha.com/')
                  ));
                },
                leading: Text('19',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('কুরআনের কথা',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Blog)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  _launchURL('http://www.nakbangla.com/');
                },
                leading: Text('20',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('নাক বাংলা',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Noman Ali Khan)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  _launchURL('http://assunnahtrust.com/');
                },
                leading: Text('21',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('আস সুন্নাহ ট্রাস্ট',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Blog)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                      page:BrowserScreen('https://www.muslimmedia.info/')
                  ));
                },
                leading: Text('22',style: TextStyle(
                  fontSize: 20,

                ),),
                title: Text('মুসলিম মিডিয়া',style: TextStyle(fontSize: 16),),
                subtitle: Text('Type: Bangla (Blog)'),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: (){

                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
