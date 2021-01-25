import 'package:flutter/material.dart';
import 'package:flag_mark/models/country.dart';
import 'package:flag_mark/views/home/country_grid.dart';

class FavTab extends StatefulWidget {
  final List<Country> countryList;

  const FavTab({Key key, this.countryList}) : super(key: key);

  @override
  _FavTabState createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CountryGrid(this.widget.countryList, isFavOnly: true);
  }
}
