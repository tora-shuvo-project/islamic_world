import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils{

  //// Save Quran Name
  static Future<void> saveQarenameFromPreference(String name)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('qareName', name);
    }catch(error){
      throw error;
    }
  }
  static Future<String> getQareNameFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('qareName')??'Ahmed al Ajmi';
  }

  //Save Font Name
  static Future<void> saveFontNameFromPreference(String name)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('fontName', name);
    }catch(error){
      throw error;
    }
  }
  static Future<String> getFontNameFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('fontName')??'Maddina';
  }

  static Future<void> saveZilaFromPreference(String zilaname)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('zilaname', zilaname);
    }catch(error){
      throw error;
    }
  }

  static Future<String> getZilaNameFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('zilaname')??'Dhaka';
  }

  static Future<void> saveArabiFormatFromPreference(String formatname)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('arabiformatname', formatname);
    }catch(error){
      throw error;
    }
  }

  static Future<String> getArabiFormatNameFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('arabiformatname')??'Arabi Indopak';
  }

  static Future<void> saveArabyFontPreference(String formatname)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('arabifont', formatname);
    }catch(error){
      throw error;
    }
  }

  static Future<String> getArabiFontFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('arabifont')??'Maddina';
  }

}


