import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'weather_response.dart';

class ApiService {
  Dio dio = Dio();
  String apiKey = "dcc4356ce129c899a0a63a7123dabac7";

  Future<WeatherResponse?> getData(double lat, double lon) async {
    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey';
    if (await InternetConnection().hasInternetAccess == true) {
      var result = await dio.get(url);
      if (result.statusCode == 200) {
        return WeatherResponse.fromJson(result.data);
      }
    }
    return null;
  }
}
