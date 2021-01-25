import 'package:flag_mark/theme.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Card(
          color: ThemeColors.lightNavy,
          elevation: 6,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
              side: BorderSide(color: Colors.black54, width: 1)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Could not reach the server. Are you connected to the Internet?",
                  style: TextStyles.cardSubtitle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    child: Text("Retry"),
                    color: ThemeColors.neonCyan,
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () => {retryCallback()},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
