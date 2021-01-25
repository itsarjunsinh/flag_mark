import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flag/flag.dart';
import 'package:flag_mark/models/country.dart';
import 'package:flag_mark/theme.dart';
import 'package:flag_mark/view_models/home_view_model.dart';

/// Creates a card grid with country flags. Option argument can limit to only favorite countries.
class CountryGrid extends StatelessWidget {
  final List<Country> countryList;

  /// If set to true, only favorite countries will be displayed.
  final bool isFavOnly;

  const CountryGrid(this.countryList, {Key key, this.isFavOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        return Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(children: [
            new Flag(
              countryList[index].code,
              height: 100,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            new Text(
              countryList[index].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.cardTitle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: new Text(
                      countryList[index].region,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.cardSubtitle,
                    ),
                  ),
                  Consumer<HomeViewModel>(
                    builder: (_, homeViewModel, __) => new IconButton(
                      color: homeViewModel.isFavorite(countryList[index].code)
                          ? ThemeColors.neonCyan
                          : ThemeColors.lightGrey,
                      icon: Icon(
                          homeViewModel.isFavorite(countryList[index].code)
                              ? Icons.star
                              : Icons.star_outline),
                      onPressed: () {
                        homeViewModel.toggleFavorite(countryList[index].code);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: .95),
    );
  }
}
