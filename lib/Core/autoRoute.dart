import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkLogin() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid') ?? '';
    if (uid.isNotEmpty) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}
