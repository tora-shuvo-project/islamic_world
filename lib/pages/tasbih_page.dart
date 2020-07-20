
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

class TasbihScreen extends StatefulWidget {
  @override
  _TasbihScreenState createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {

  int count=0;
  String _myActivity='সুবহানাল্লাহ';
  Widget _appBar(){
    return Container(
      color: Colors.green.withOpacity(.3),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                  Navigator.of(context).pop();
                }),
                FittedBox(
                  child: Text('তাসবিহ',style:  TextStyle(
                      color: Colors.white, fontSize: 20
                  ), ),
                ),
                Row(children: <Widget>[
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
                ],)

              ],
            ),
          ),

        ),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,

        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
              color: Colors.green.withOpacity(.1),
            child: MediaQuery.of(context).orientation==Orientation.portrait?
            Column(
              children: <Widget>[

            Container(
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
                          count=0;
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
                        {
                          "display": "সুবাহানাল্লাহি ওয়া বিহামদিহী",
                          "value": "subahanlahi oyabihamdihi",
                        },
                        {
                          "display": "সুবাহানাল্লাহিল আজিম",
                          "value": "subanlahil ajim",
                        },
                        {
                          "display": "সুবাহানাকা-লহুম্মা",
                          "value": "subahanaka llahumma",
                        },
                        {
                          "display": "লা-হাওলা-ওয়ালা-কুয়া-তা-ইল্লাবিল্লাহ",
                          "value": "লা-হাওলা-ওয়ালা-কুয়া-তা-ইল্লাবিল্লাহ",
                        },
                        {
                          "display": "আসতাগফিরুল্লাহ",
                          "value": "আসতাগফিরুল্লাহ",
                        },
                        {
                          "display": "আসতাগফিরুল্লাহ অয়াতুবু ইলাইক",
                          "value": "আসতাগফিরুল্লাহ অয়াতুবু ইলাইক",
                        },
                        {
                          "display": "সল্লালহু আলাইহিওসল্লাম",
                          "value": "সল্লালহু আলাইহিওসল্লাম",
                        },
                        {
                          "display": "আল্লহুম্মা বিসমিকা আমুতু অআহ ইয়া",
                          "value": "আল্লহুম্মা বিসমিকা আমুতু অআহ ইয়া",
                        },
                        {
                          "display": "ইয়ারহামুক আল্লাহ",
                          "value": "ইয়ারহামুক আল্লাহ",
                        },
                        {
                          "display": "হাসবুন আল্লাহু ওয়া নিয়ামাল অকিল",
                          "value": "হাসবুন আল্লাহু ওয়া নিয়ামাল অকিল",
                        },
                        {
                          "display": "আল্লাহুম্মা আজিরনি মিনান নার",
                          "value": "আল্লাহুম্মা আজিরনি মিনান নার",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),

              SizedBox(height: 20,),
                InkWell(
                    onTap: (){
      setState(() {
                    count++;
                  });
                    },
                  child: Stack(
                    children: <Widget>[
                      Flexible(child: Image.asset("images/tasbeeh.png", height: 350,width: 350,)),
                      Container(alignment: Alignment.center,
                          height:350, width:350,
                          child: FittedBox(child: Text("$count", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),)))
                    ],
                  ),
                ),

               RaisedButton(
                 color: Colors.green,
                 onPressed:(){
                 setState(() {
                   count=0;
                 });

               },child: Text("Reset", style: TextStyle(color: Colors.white),),)
              ],
            ): Row(
              children: <Widget>[

                InkWell(
                  onTap: (){
                    setState(() {
                      count++;
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Flexible(child: Image.asset("images/tasbeeh.png", height: 350,width: 350,)),
                      Container(alignment: Alignment.center,
                          height:350, width:350,
                          child: FittedBox(child: Text("$count", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),)))
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    Container(
                      width: MediaQuery.of(context).size.width/2,
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
                            count=0;
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
                          {
                            "display": "সুবাহানাল্লাহি ওয়া বিহামদিহী",
                            "value": "subahanlahi oyabihamdihi",
                          },
                          {
                            "display": "সুবাহানাল্লাহিল আজিম",
                            "value": "subanlahil ajim",
                          },
                          {
                            "display": "সুবাহানাকা-লহুম্মা",
                            "value": "subahanaka llahumma",
                          },
                          {
                            "display": "লা-হাওলা-ওয়ালা-কুয়া-তা-ইল্লাবিল্লাহ",
                            "value": "লা-হাওলা-ওয়ালা-কুয়া-তা-ইল্লাবিল্লাহ",
                          },
                          {
                            "display": "আসতাগফিরুল্লাহ",
                            "value": "আসতাগফিরুল্লাহ",
                          },
                          {
                            "display": "আসতাগফিরুল্লাহ অয়াতুবু ইলাইক",
                            "value": "আসতাগফিরুল্লাহ অয়াতুবু ইলাইক",
                          },
                          {
                            "display": "সল্লালহু আলাইহিওসল্লাম",
                            "value": "সল্লালহু আলাইহিওসল্লাম",
                          },
                          {
                            "display": "আল্লহুম্মা বিসমিকা আমুতু অআহ ইয়া",
                            "value": "আল্লহুম্মা বিসমিকা আমুতু অআহ ইয়া",
                          },
                          {
                            "display": "ইয়ারহামুক আল্লাহ",
                            "value": "ইয়ারহামুক আল্লাহ",
                          },
                          {
                            "display": "হাসবুন আল্লাহু ওয়া নিয়ামাল অকিল",
                            "value": "হাসবুন আল্লাহু ওয়া নিয়ামাল অকিল",
                          },
                          {
                            "display": "আল্লাহুম্মা আজিরনি মিনান নার",
                            "value": "আল্লাহুম্মা আজিরনি মিনান নার",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                    RaisedButton(
                      color: Colors.green,
                      onPressed:(){
                        setState(() {
                          count=0;
                        });

                      },child: Text("Reset", style: TextStyle(color: Colors.white),),)
                  ],
                )

              ],
            )
          ),
        ),
      ),
    );
  }
}
