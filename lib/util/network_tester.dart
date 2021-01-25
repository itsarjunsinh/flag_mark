import 'package:dio/dio.dart';

class NetworkTester {
  Future<bool> isNetworkConnected() async {
    bool result = false;

    try {
      Response testResponse = await Dio().get("https://google.com");
      if (testResponse.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      print(e);
    }

    return result;
  }
}
