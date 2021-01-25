/// Data class that holds Country List API Response
class CountryDataset {
  final Map<String, CountryInfo> data;

  CountryDataset({
    this.data,
  });

  factory CountryDataset.fromJson(Map<String, dynamic> json) => CountryDataset(
        data: Map.from(json["data"]).map((k, v) =>
            MapEntry<String, CountryInfo>(k, CountryInfo.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "data": Map.from(data)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class CountryInfo {
  final String country;
  final String region;

  CountryInfo({
    this.country,
    this.region,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
        country: json["country"],
        region: json["region"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "region": region,
      };
}
