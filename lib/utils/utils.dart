import 'package:shared_preferences/shared_preferences.dart';

class Utils{

  Future<void> saveQarenameFromPreference(String name)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('qareName', name);
    }catch(error){
      throw error;
    }
  }

  Future<String> getQareNameFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('qareName')??'Ahmed al Ajmi';
  }

}