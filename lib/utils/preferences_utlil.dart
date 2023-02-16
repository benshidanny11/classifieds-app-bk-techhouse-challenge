import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
}
