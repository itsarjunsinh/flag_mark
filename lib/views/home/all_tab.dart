import 'package:flutter/material.dart';
import 'package:flag_mark/models/country.dart';
import 'package:flag_mark/views/home/country_grid.dart';

class AllTab extends StatefulWidget {
  final List<Country> countryList;

  const AllTab({Key key, this.countryList}) : super(key: key);

  @override
  _AllTabState createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CountryGrid(this.widget.countryList);
  }
}
