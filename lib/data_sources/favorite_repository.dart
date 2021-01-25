import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRepository {
  final String key = "FAV_COUNTRIES";

  Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  void setFavorites(List<String> favoriteCountryCodes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, favoriteCountryCodes);
  }
}
