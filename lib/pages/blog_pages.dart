import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Islamic Blog'),
      ),
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
              title: Text('True Muslims',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://waytotawheed.com/%E0%A6%87%E0%A6%B8%E0%A6%B2%E0%A6%BE%E0%A6%AE%E0%A6%BF%E0%A6%95-%E0%A6%AC%E0%A6%87-%E0%A6%B8%E0%A6%AE%E0%A6%BE%E0%A6%B9%E0%A6%BE%E0%A6%B0/');
              },
              leading: Text('2',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Way To Tawheed',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://alquranbd.com/index.php');
              },
              leading: Text('3',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Alquran Bd',style: TextStyle(fontSize: 16),),
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
                _launchURL('http://www.quraanshareef.org/');
              },
              leading: Text('4',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Quraan Shareef',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://deenilhaq.wordpress.com/');
              },
              leading: Text('5',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Deen Ilhaq',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://islamqabd.com/');
              },
              leading: Text('6',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Islam Qa Bd',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://omukderkotha1.blogspot.com/');
              },
              leading: Text('7',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Omuk Der Kotha',style: TextStyle(fontSize: 16),),
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
              title: Text('Hadith Bd',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://tablighjammat.wordpress.com/');
              },
              leading: Text('9',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Tabligh Jammat',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://habibur.com/salat/districts/dhaka/fullyear/');
              },
              leading: Text('10',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Habibur',style: TextStyle(fontSize: 16),),
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
              title: Text('Free Quran Mp3',style: TextStyle(fontSize: 16),),
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
              title: Text('House Of Quran',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://tauheed-sunnat.com/quran-audio-mp3');
              },
              leading: Text('13',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Tauheed Sunnat',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://backtojannah.com/');
              },
              leading: Text('14',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Backto Jannah',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://islamqa.info/bn');
              },
              leading: Text('15',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Islam Qa',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://www.quraneralo.com/');
              },
              leading: Text('16',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Quraner Alo',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://amarspondon.wordpress.com/');
              },
              leading: Text('17',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Amar Spondon',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://adnanfaisal.wordpress.com/');
              },
              leading: Text('18',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Adnan Faisal',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://quranerkotha.com/');
              },
              leading: Text('19',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Quraner Kotha',style: TextStyle(fontSize: 16),),
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
              title: Text('Nak Bangla',style: TextStyle(fontSize: 16),),
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
              title: Text('As Sunnah Trust',style: TextStyle(fontSize: 16),),
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
                _launchURL('https://www.muslimmedia.info/');
              },
              leading: Text('22',style: TextStyle(
                fontSize: 20,

              ),),
              title: Text('Muslim Media',style: TextStyle(fontSize: 16),),
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
    );
  }
}
