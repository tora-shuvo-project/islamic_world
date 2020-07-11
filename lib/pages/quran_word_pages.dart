import 'package:flutter/material.dart';
import 'package:searchtosu/DataBaseHelper/database_helper.dart';
import 'package:searchtosu/FinalModels/quran_word_models.dart';
import 'package:searchtosu/pages/quran_word_pages_details_screen.dart';

class QuranWordPages extends StatefulWidget {

  static final route='/quranWord';

  @override
  _QuranWordPagesState createState() => _QuranWordPagesState();
}

class _QuranWordPagesState extends State<QuranWordPages> {

  List<QuranWordModels> quranwordmodels=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DatabaseHelper.getAllQuranWordFromTable().then((rows){
      setState(() {
        rows.forEach((row) {
          quranwordmodels.add(QuranWordModels.fromMap(row));
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('কোরআনের শব্দ'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5),
            width: double.infinity,
            color: Colors.green,
            height: 40,
            child: FlatButton(
              child: Text('শুরুর কথা',style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),),
              onPressed: (){
                showModalBottomSheet(context: context, builder: (context){
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text("আমি কোরআনকে সহজ করে দিয়েছি বোঝার জন্যে । অতএব, কোন চিন্তাশীল আছে কি ? (সূরা কামার  ৫৪:১৭, ২২, ৩২, ৪০) "
                          "এই কথাটি আল্লাহ্‌ কোরআনে ৪ বার বলেছেন । আল্লাহ্‌ আমাদেরকে কোরআন নিয়ে চিন্তা ভাবনা করতে বলেছেন, "
                          "একে অধ্যয়ন করতে বলেছেন; বোঝার জন্য সহজ করে দিয়েছি বলে, আমাদেরকে একে বোঝার তাগিদ দিয়েছেন । "
                          "কিন্তু আল-কোরআন আসলে কতটা সহজ ?? চলুন দেখা যাক ......পুরো কোরআনে মোট শব্দ আছে ৭৭,৪২৯ টি ।"
                          " কিন্তু পুনারাবৃত্তি আর একই শব্দের বিভিন্ন ব্যাবহারগুলো বাদ দিলে শব্দ সংখ্যা দাড়ায় মাত্র ৪৮৪৫ টি [১] । "
                          "এর মধ্যে সর্বাধিক  ব্যবহৃত মাত্র ৬০টি শব্দের অর্থ জানলেই পুরো কোরআনের মোট শব্দের অর্ধেক (৫০%) শব্দের সাথে আমাদের পরিচয় হয়ে যাবে  ইনশা আল্লাহ্। "
                          " আরও ২৫% শব্দের অর্থ জানতে আর মাত্র ২৬০ টি শব্দের সাথে পরিচিত হতে হবে । "
                          "অর্থাৎ মাত্র ৩২০টি শব্দ শিখে আমরা কোরআনের ৭৫% অংশের শাব্দিক অর্থ বুঝতে পারবো । "
                          "সুবহানাল্লাহ !  বিস্ময়কর ভাবে কত অল্প সংখ্যক শব্দ ব্যবহার করে আল্লাহ এই বিশাল কোরআনের বেশির ভাগ অংশ সাজিয়েছেন !"
                          " \nযেকোন ভাষা জানতে তার শব্দ ভান্ডার বাড়ানো ছাড়া কোন বিকল্প নেই । "
                          "একটি শিশু যখন কথা বলা শিখে তখন সে কিন্তু আগে ব্যকরণ শিখে না, শব্দ শিখে । "
                          "তাই, কোরআনকে বুঝতে হলে আমাদের  কোরআনিক শব্দ ভান্ডার বাড়াতে হবে । "
                          " চলুন  আমরা কোরআনের সর্বাধিক ব্যবহৃত শব্দগুলোর  সাথে ধীরে ধীরে পরিচিত হই । "
                          "নিচের ছকে এই শব্দ গুলো, পুনারাবৃত্তি সংখ্যার ভিত্তিতে অধঃক্রমে সাজানো হল । "
                          "প্রতিটি  শব্দের অর্থ এবং কোরআন হতে এগুলোর সহজ উদাহরণ দেয়া হলো । "
                          " উদাহরণ গুলোর বেশির ভাগই আল-কোরআনের ২৯ ও ৩০ পারার ছোট ছোট আয়াত থেকে নেয়া হয়েছে ।  ",
                        style: TextStyle(
                          fontSize: 18,
                        ),),
                    ),
                  );
                });
              },
            ),
          ),
          Expanded(
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(quranwordmodels.length, (index) {
                return Card(
                    color: quranwordmodels[index].serial_no%2==0?Colors.green.withOpacity(.8):Colors.green.withOpacity(.9),
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QuranWordPagesDetailsScreen(quranwordmodels[index])));
                      },
                      title: Text('Day-${quranwordmodels[index].serial_no}',style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),),
                      subtitle: new RichText(
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: '\nTask ${quranwordmodels[index].taskNumber}\n\n'),
                            new TextSpan(text: '${quranwordmodels[index].percent_complete} Complete',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: .8

                                )),
                          ],
                        ),
                      ),
                    )
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
