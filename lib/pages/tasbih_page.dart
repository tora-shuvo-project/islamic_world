import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class TasbihScreen extends StatefulWidget {
  @override
  _TasbihScreenState createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {

  int count=0;
  String _myActivity='সুবহানাল্লাহ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('তাসবিহ'),
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.history,color: Colors.white,),
            onPressed: (){
              setState(() {
                Toast.show('ইং-শা-আল্লাহ পরবর্তি আপডেট এ এটি Add করা হবে।', context);
              });
            },
          ),

          IconButton(
            icon: Icon(Icons.refresh,color: Colors.white,),
            onPressed: (){
              setState(() {
                count=0;
              });
            },
          ),

        ],
      ),
      body: Column(
        children: <Widget>[

          Expanded(
            child: Container(
              color: Colors.green.withOpacity(.1),
              child: DropDownFormField(
                titleText: 'তাসবিহ সিলেক্ট করুন',
                hintText: 'সুবহানাল্লাহ',
                value: _myActivity,
                onSaved: (value) async{
                  setState(() {
                    _myActivity = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _myActivity = value;
                  });
                },
                dataSource: [
                  {
                    "display": "সুবহানাল্লাহ",
                    "value": "সুবহানাল্লাহ",
                  },
                  {
                    "display": "আলহামদুলিল্লাহ",
                    "value": "আলহামদুলিল্লাহ",
                  },
                  {
                    "display": "আল্লাহু আকবার",
                    "value": "আল্লাহু আকবার",
                  },
                  {
                    "display": "আল্লাহুম্মা আনতাস-সালাম",
                    "value": "Salah Budair",
                  },
                  {
                    "display": "লা ইলাহা ইল্লালা",
                    "value": "Ahmed al Ajmi",
                  },
                ],
                textField: 'display',
                valueField: 'value',
              ),
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.green.withOpacity(.1),
              alignment: Alignment.center,
            child: Text('$count',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            ),
          ),
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: (){
                setState(() {
                  count++;
                });
              },
              child: Container(
                color: Colors.green.withOpacity(.15),
                alignment: Alignment.center,
                child: Image.asset('images/tasbih.png',),
              ),
            ),
          )
        ],
      ),
    );
  }
}
