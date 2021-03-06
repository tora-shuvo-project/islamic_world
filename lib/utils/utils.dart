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

  // Save Zila Name
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

  /// Save Arabi Text Format
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
    return prefs.getString('arabiformatname')??'Arabi Utmanic';
  }

  // Save Arabi Font Name
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
    return prefs.getString('arabifont')??'QalamMajid';
  }

  // Save Quran Arabu Font Size
  static Future<void> saveQuranArabyFontsize(String size)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('quranarabifont', size);
    }catch(error){
      throw error;
    }
  }

  static Future<String> getQuranArabiFontSizeFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('quranarabifont')??'18';
  }

  // Save Arabi Font Size
  static Future<void> saveArabyFontsize(String size)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('arabifontSize', size);
    }catch(error){
      throw error;
    }
  }

  static Future<String> getArabiFontSizeFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('arabifontSize')??'18';
  }

  // Save Prayer Method
  static Future<void> savePrayerMethosTOPreference(String type)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      prefs.setString('prayerMethod', type);
    }catch(error){
      throw error;
    }
  }

  static Future<String> getPrayerMethodFromPreference()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('prayerMethod')??'hanafi';
  }

}


