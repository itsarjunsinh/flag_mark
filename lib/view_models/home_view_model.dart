import 'package:flag_mark/data_sources/country_repository.dart';
import 'package:flag_mark/data_sources/favorite_repository.dart';
import 'package:flag_mark/models/country.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  Future<List<Country>> countryList;

  List<Country> favCountryList = [];
  List<String> favCountryCodes = [];

  HomeViewModel() {
    _fetchAllCountries();
    _generateFavorites();
  }

  void _fetchAllCountries() async {
    countryList = CountryRepository().getAllCountries();
  }

  void _generateFavorites() async {
    favCountryCodes = await FavoriteRepository().getFavorites();
    await countryList.then((data) {
      favCountryList
          .addAll(data.where((i) => favCountryCodes.contains(i.code)));
    });
    notifyListeners();
  }

  bool isFavorite(String countryCode) {
    return favCountryCodes.contains(countryCode);
  }

  void toggleFavorite(String countryCode) async {
    if (isFavorite(countryCode)) {
      favCountryCodes.remove(countryCode);
      favCountryList.removeWhere((i) => i.code == countryCode);
    } else {
      favCountryCodes.add(countryCode);
      await countryList.then((data) {
        favCountryList.add(data.firstWhere((i) => i.code == countryCode));
      });
    }
    notifyListeners();
    FavoriteRepository().setFavorites(favCountryCodes);
  }
}
