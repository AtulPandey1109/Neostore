import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage{
  static SharedPreferences? _prefs;

  static void saveToken(String token) async{
    _prefs = await SharedPreferences.getInstance();
    _prefs!.setString('token', token);
  }

  static Future<String> getToken() async{
    _prefs = await SharedPreferences.getInstance();
    return _prefs!.getString('token')??'';
  }

  static void removeToken() async{
    _prefs = await SharedPreferences.getInstance();
   _prefs!.remove('token');
  }

  static void saveAddress(List<String> address) async{
    _prefs = await SharedPreferences.getInstance();
    _prefs!.setStringList('address', address);
  }

  static Future<List<String>> getAddress() async{
    _prefs = await SharedPreferences.getInstance();
    return _prefs!.getStringList('address')??[];
  }

}