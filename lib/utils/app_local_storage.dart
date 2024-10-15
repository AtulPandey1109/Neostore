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

 static void saveGoogleAccessToken(String token) async{
   _prefs = await SharedPreferences.getInstance();
   _prefs!.setString('googleToken', token);
 }

}