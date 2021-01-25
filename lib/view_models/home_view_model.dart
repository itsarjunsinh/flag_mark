import 'package:flutter/material.dart';
import 'package:flag_mark/data_sources/country_repository.dart';
import 'package:flag_mark/data_sources/favorite_repository.dart';
import 'package:flag_mark/models/country.dart';
import 'package:flag_mark/util/network_tester.dart';

class HomeViewModel extends ChangeNotifier {
  Future<bool> isNetworkConnected;
  Future<List<Country>> countryList;

  List<Country> favCountryList = [];
  List<String> favCountryCodes = [];

  HomeViewModel() {
    loadCountryLists();
  }

  void loadCountryLists() async {
    isNetworkConnected = NetworkTester().isNetworkConnected();
    countryList = CountryRepository().getAllCountries();
    _generateFavorites();
  }

  void _generateFavorites() async {
    favCountryCodes = await FavoriteRepository().getFavorites();

    // Generate favorite country list.
    await countryList.then(
      (list) {
        favCountryList.addAll(
          list.where(
            (i) => favCountryCodes.contains(i.code),
          ),
        );
      },
    );
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

      // Add to favorite country list.
      await countryList.then(
        (list) {
          favCountryList.add(
            list.firstWhere((i) => i.code == countryCode),
          );
        },
      );
    }
    notifyListeners();
    FavoriteRepository().setFavorites(favCountryCodes);
  }
}
