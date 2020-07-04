import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:searchtosu/pages/test_page.dart';
import 'package:searchtosu/utils/utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String _myActivity;
  Utils utils;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myActivity = '';
    utils=Utils();
    utils.getQareNameFromPreference().then((value) {
      setState(() {
        _myActivity=value;
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
            alignment: Alignment.center,
            width: double.infinity,
            child: DropDownFormField(
              titleText: 'Select Qare',
              hintText: 'Please choose one',
              value: _myActivity,
              onSaved: (value) async{
                setState(() {
                  _myActivity = value;
                  utils.saveQarenameFromPreference(value);
                });
              },
              onChanged: (value) {
                setState(() {
                  utils.saveQarenameFromPreference(value);
                  _myActivity = value;
                });
              },
              dataSource: [
                {
                  "display": "Abdur rahman Sudais",
                  "value": "Abdurrahman Sudais",
                },
                {
                  "display": "Saad al Ghamidi",
                  "value": "Saad al Ghamidi",
                },
                {
                  "display": "Salah Budair",
                  "value": "Salah Budair",
                },
                {
                  "display": "Ahmed al Ajmi",
                  "value": "Ahmed al Ajmi",
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ),
          RaisedButton(
            child: Text('Test Screen'),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>TestScreen()
              ));
            },
          ),
        ],
      ),
    );
  }
}
