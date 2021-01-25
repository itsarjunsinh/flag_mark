import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flag_mark/models/country.dart';
import 'package:flag_mark/models/country_dataset.dart';
import 'package:flutter/cupertino.dart';

class CountryRepository {
  Future<List<Country>> getAllCountries() async {
    try {
      Response apiResponse =
          await Dio().get("https://api.first.org/data/v1/countries");

      if (apiResponse.statusCode == 200) {
        var json = jsonDecode(apiResponse.toString());
        return _generateCountryList(CountryDataset.fromJson(json));
      } else {
        FlutterError("Request Failed");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  List<Country> _generateCountryList(CountryDataset dataset) {
    List<Country> allCountries = [];

    dataset.data.forEach(
      (countryCode, countryInfo) => {
        allCountries.add(
          Country(countryCode, countryInfo.country, countryInfo.region),
        ),
        print(countryInfo.country)
      },
    );

    return allCountries;
  }
}
