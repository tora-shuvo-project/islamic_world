import 'package:shared_preferences/shared_preferences.dart';

class Utils{

  //// Save Quran Name
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

  //Save Font Name
  Future<void> saveFontNameFromPreference(String name)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('fontName', name);
    }catch(error){
      throw error;
    }
  }
  Future<String> getFontNameFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('fontName')??'Maddina';
  }

}