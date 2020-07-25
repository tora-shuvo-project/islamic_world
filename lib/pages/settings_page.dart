import 'dart:ffi';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:searchtosu/utils/utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String _myActivity;
  String _arabyTextStyle;
  String _arabyStyle;
  String _fontName;
  String _prayertype;
  String _fontFamily;
  String _quranArabiFontSize;
  String _arabiFontSize;
  double fontsize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myActivity = '';
    _arabyTextStyle = '';
    _fontName = '';
    _prayertype = '';
    _fontFamily='QalamMajid';
    _arabiFontSize='';
    _arabyStyle = 'بسم الله الرحمن الرحيم';
    Utils.getQuranArabiFontSizeFromPreference().then((value){
      setState(() {
        _quranArabiFontSize=value;
        fontsize=double.parse(value);
      });
    });
    Utils.getArabiFontSizeFromPreference().then((value){
      setState(() {
        _arabiFontSize=value;
      });
    });
    Utils.getQareNameFromPreference().then((value) {
      setState(() {
        _myActivity=value;
        print(value);
      });
    });
    Utils.getArabiFormatNameFromPreference().then((value){
      setState(() {
        _arabyTextStyle=value;
        print(value);
      });
    });
    Utils.getArabiFontFromPreference().then((value){
      setState(() {
        _fontName=value;
        print(value);
      });
    });

    Utils.getPrayerMethodFromPreference().then((value){
      setState(() {
        _prayertype=value;
        print(value);
      });
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[

          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text('$_arabyStyle',style: TextStyle(
              fontSize: fontsize,
                fontFamily: _fontFamily
            ),),
          ),
          Container(
            color: Colors.green.withOpacity(.2),
            alignment: Alignment.center,
            width: double.infinity,
            child: DropDownFormField(
              titleText: 'কুরআন আরাবি ফন্ট সাইজ',
              hintText: 'Please choose one',
              value: _quranArabiFontSize,
              onSaved: (value) async{
                setState(() {
                  _quranArabiFontSize = value;
                  Utils.saveQuranArabyFontsize(value);
                  fontsize=double.parse(value);
                });
              },
              onChanged: (value) {
                setState(() {
                  Utils.saveQuranArabyFontsize(value);
                  _quranArabiFontSize = value;
                  fontsize=double.parse(value);
                });
              },
              dataSource: [
                {
                  "display": "১৪",
                  "value": "14",
                },
                {
                  "display": "১৫",
                  "value": "15",
                },
                {
                  "display": "১৬",
                  "value": "16",
                },
                {
                  "display": "১৭",
                  "value": "17",
                },
                {
                  "display": "১৮",
                  "value": "18",
                },
                {
                  "display": "১৯",
                  "value": "19",
                },
                {
                  "display": "২০",
                  "value": "20",
                },
                {
                  "display": "২১",
                  "value": "21",
                },
                {
                  "display": "২২",
                  "value": "22",
                },
                {
                  "display": "২৩",
                  "value": "23",
                },
                {
                  "display": "২৪",
                  "value": "24",
                },
                {
                  "display": "২৫",
                  "value": "25",
                },
                {
                  "display": "২৬",
                  "value": "26",
                },
                {
                  "display": "২৭",
                  "value": "27",
                },
                {
                  "display": "২৮",
                  "value": "28",
                },
                {
                  "display": "২৯",
                  "value": "29",
                },
                {
                  "display": "৩০",
                  "value": '30',
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ),
          SizedBox(height: 5,),
          Container(
            color: Colors.green.withOpacity(.2),
            alignment: Alignment.center,
            width: double.infinity,
            child: DropDownFormField(
              titleText: 'কারী সিলেক্ট করুণ',
              hintText: 'Please choose one',
              value: _myActivity,
              onSaved: (value) async{
                setState(() {
                  _myActivity = value;
                  Utils.saveQarenameFromPreference(value);
                });
              },
              onChanged: (value) {
                setState(() {
                  Utils.saveQarenameFromPreference(value);
                  _myActivity = value;
                });
              },
              dataSource: [
                {
                  "display": "আব্দুর রহমান সুদাইস",
                  "value": "Abdurrahman Sudais",
                },
                {
                  "display": "সাদ আল গামিদি",
                  "value": "Saad al Ghamidi",
                },
                {
                  "display": "মিসারী বিন রাসেদ আল আফসি",
                  "value": "al-mishary",
                },
                {
                  "display": "সালাহ বুদির",
                  "value": "Salah Budair",
                },
                {
                  "display": "আহমেদ আল আজিমি",
                  "value": "Ahmed al Ajmi",
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ),

          SizedBox(height: 5,),
          Container(
            color: Colors.green.withOpacity(.2),
            alignment: Alignment.center,
            width: double.infinity,
            child: DropDownFormField(
              titleText: 'কুরআন এর আরবি ফরম্যাট',
              hintText: 'Please choose one',
              value: _arabyTextStyle,
              onSaved: (value) async{
                setState(() {
                  _arabyTextStyle = value;
                  Utils.saveArabiFormatFromPreference(value);
                  if(value==''){
                    setState(() {
                      _arabyStyle='بسم الله الرحمن الرحيم';
                    });
                  }else if(value==''){
                    setState(() {
                      _arabyStyle='بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
                    });
                  }else{
                    setState(() {
                      _arabyStyle='بِسۡمِ اللّٰہِ الرَّحۡمٰنِ الرَّحِیۡمِ ﴿۱﴾';
                    });
                  }
                });
              },
              onChanged: (value) {
                setState(() {
                  _arabyTextStyle = value;
                  Utils.saveArabiFormatFromPreference(value);
                  if(value=='Arabi Simple'){
                    setState(() {
                      _arabyStyle='بسم الله الرحمن الرحيم';
                    });
                  }else if(value=='Arabi Utmanic'){
                    setState(() {
                      _arabyStyle='بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
                    });
                  }else{
                    setState(() {
                      _arabyStyle='بِسۡمِ اللّٰہِ الرَّحۡمٰنِ الرَّحِیۡمِ ﴿۱﴾';
                    });
                  }
                });
              },
              dataSource: [
                {
                  "display": "আরাবি সিম্পল",
                  "value": "Arabi Simple",
                },
                {
                  "display": "আরাবি উঠ-মানিক",
                  "value": "Arabi Utmanic",
                },
                {
                  "display": "আরাবি ইন্ডোপাক",
                  "value": "Arabi Indopak",
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ),
          SizedBox(height: 5,),
          Container(
            color: Colors.green.withOpacity(.2),
            alignment: Alignment.center,
            width: double.infinity,
            child: DropDownFormField(
              titleText: 'অজিফা,দূয়া ইত্যাদির জন্য আরাবি ফন্ট সাইজ',
              hintText: 'Please choose one',
              value: _arabiFontSize,
              onSaved: (value) async{
                setState(() {
                  _arabiFontSize = value;
                  Utils.saveArabyFontsize(value);

                });
              },
              onChanged: (value) {
                setState(() {
                  _arabiFontSize = value;
                  Utils.saveArabyFontsize(value);

                });
              },
              dataSource: [
                {
                  "display": "১৪",
                  "value": "14",
                },
                {
                  "display": "১৫",
                  "value": "15",
                },
                {
                  "display": "১৬",
                  "value": "16",
                },
                {
                  "display": "১৭",
                  "value": "17",
                },
                {
                  "display": "১৮",
                  "value": "18",
                },
                {
                  "display": "১৯",
                  "value": "19",
                },
                {
                  "display": "২০",
                  "value": "20",
                },
                {
                  "display": "২১",
                  "value": "21",
                },
                {
                  "display": "২২",
                  "value": "22",
                },
                {
                  "display": "২৩",
                  "value": "23",
                },
                {
                  "display": "২৪",
                  "value": "24",
                },
                {
                  "display": "২৫",
                  "value": "25",
                },
                {
                  "display": "২৬",
                  "value": "26",
                },
                {
                  "display": "২৭",
                  "value": "27",
                },
                {
                  "display": "২৮",
                  "value": "28",
                },
                {
                  "display": "২৯",
                  "value": "29",
                },
                {
                  "display": "৩০",
                  "value": '30',
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ),
          SizedBox(height: 5,),
          Container(
            color: Colors.green.withOpacity(.2),
            alignment: Alignment.center,
            width: double.infinity,
            child: DropDownFormField(
              titleText: 'অজিফা,দূয়া ইত্যাদির জন্য আরাবি ফন্ট সিলেক্ট করুণ',
              hintText: 'Please choose one',
              value: _fontName,
              onSaved: (value) async{
                setState(() {
                  Utils.saveArabyFontPreference(value);
                  _fontName = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  _fontName = value;
                  Utils.saveArabyFontPreference(value);
                  if(value=='Monserat'){
                    setState(() {
                      _fontFamily='Monserat';
                    });
                  }else if(value=='Mukadimah'){
                    setState(() {
                      _fontFamily='Mukadimah';
                    });
                  }else if(value=='QalamMajid'){
                    setState(() {
                      _fontFamily='QalamMajid';
                    });
                  }else if(value=='utman'){
                    setState(() {
                      _fontFamily='utman';
                    });
                  }else{
                    setState(() {
                      _fontFamily='Maddina';
                    });
                  }
                });
              },
              dataSource: [
                {
                  "display": "মনসেরাত ফন্ট",
                  "value": "Monserat",
                },
                {
                  "display": "মুকাদিমাহ ফন্ট",
                  "value": "Mukadimah",
                },
                {
                  "display": "কালাম মাজিদ(হাফীজি কুরআন) ফন্ট",
                  "value": "QalamMajid",
                },
                {
                  "display": "উটমান ফন্ট",
                  "value": "utman",
                },
                {
                  "display": "মাদিনা ফন্ট",
                  "value": "Maddina",
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ),

          SizedBox(height: 5,),
          Container(
            color: Colors.green.withOpacity(.2),
            alignment: Alignment.center,
            width: double.infinity,
            child: DropDownFormField(
              titleText: 'নামাজের জন্য মাজহাব সিলেক্ট করুণ',
              hintText: 'Please choose one',
              value: _prayertype,
              onSaved: (value){
                setState(() {
                  Utils.savePrayerMethosTOPreference(value);
                  _prayertype = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  _prayertype = value;
                  Utils.savePrayerMethosTOPreference(value);

                });
              },
              dataSource: [
                {
                  "display": "হানাফী মাজহাব",
                  "value": "hanafi",
                },
                {
                  "display": "সাফী,মালিকী,হানবালি",
                  "value": "safe",
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ),

        ],
      ),
    );
  }
}
