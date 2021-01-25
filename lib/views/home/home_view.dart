import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flag_mark/models/country.dart';
import 'package:flag_mark/theme.dart';
import 'package:flag_mark/view_models/home_view_model.dart';
import 'package:flag_mark/views/home/country_grid.dart';
import 'package:flag_mark/widgets/loading_widget.dart';
import 'package:flag_mark/widgets/no_network_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'FlagMark',
            style: TextStyles.appTitle,
          ),
          centerTitle: true,
          backgroundColor: ThemeColors.lightestNavy,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).accentColor,
            tabs: [
              Tab(
                icon: Icon(Icons.flag),
                text: "All Flags",
              ),
              Tab(
                icon: Icon(Icons.star_border_outlined),
                text: "Favorites",
              )
            ],
          ),
        ),
        body: ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
          child: Consumer<HomeViewModel>(
            builder: (_, _viewModel, __) => FutureBuilder(
              future: _viewModel.isNetworkConnected,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    // Check if connection works
                    if (snapshot.data) {
                      return FutureBuilder(
                        future: _viewModel.countryList,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.done:
                              // Display screens
                              return TabBarView(children: [
                                AllTab(countryList: snapshot.data),
                                FavTab(countryList: _viewModel.favCountryList),
                              ]);
                              break;
                            default:
                              return LoadingWidget();
                          }
                        },
                      );
                    } else {
                      // TODO: No connection
                      return NoNetworkWidget(
                          retryCallback: _viewModel.loadCountryLists);
                    }
                    break;
                  default:
                    return LoadingWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

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
