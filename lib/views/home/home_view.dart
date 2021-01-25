import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flag_mark/theme.dart';
import 'package:flag_mark/view_models/home_view_model.dart';
import 'package:flag_mark/views/home/all_tab.dart';
import 'package:flag_mark/views/home/fav_tab.dart';
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
                              // Country List ready. Display screens.
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
                      return NoNetworkWidget(
                          retryCallback: _viewModel.loadData);
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
