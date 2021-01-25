import 'package:flutter/material.dart';

class NoNetworkWidget extends StatelessWidget {
  final VoidCallback retryCallback;

  const NoNetworkWidget({
    @required this.retryCallback,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
              "Could not reach the server. Are you connected to the Internet?"),
          RaisedButton(
            child: Text("Retry"),
            onPressed: () => {retryCallback()},
          ),
        ],
      ),
    );
  }
}
