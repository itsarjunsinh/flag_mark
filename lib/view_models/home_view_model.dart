import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flag_mark/data_sources/country_repository.dart';
import 'package:flag_mark/data_sources/favorite_repository.dart';
import 'package:flag_mark/models/country.dart';
import 'package:flag_mark/util/network_tester.dart';

class HomeViewModel extends ChangeNotifier {
  Future<bool> isNetworkConnected;
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  Future<List<Country>> countryList;
  List<Country> favCountryList = [];
  List<String> favCountryCodes = [];

  HomeViewModel() {
    loadData();
  }

  void loadData() async {
    isNetworkConnected = NetworkTester().isNetworkConnected();

    isNetworkConnected.then((isConnected) {
      // Subscribe to connectivity change when network not connected.
      // Unsubscribe if connection established.
      if (isConnected) {
        connectivitySubscription?.cancel();
      } else {
        connectivitySubscription = Connectivity().onConnectivityChanged.listen(
          (ConnectivityResult result) {
            // Auto (re)load data when connected to WiFi or Mobile Data.
            switch (result) {
              case ConnectivityResult.none:
                return;
              default:
                loadData();
                return;
            }
          },
        );
      }
    });
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

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription?.cancel();
  }
}
