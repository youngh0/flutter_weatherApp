import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather with ChangeNotifier {
  final String key = '8a9ec30a2155643a638723b6f7dc7abf&units=metric';
  final String url = 'https://api.openweathermap.org/data/2.5/weather';

  Map<String, dynamic> _weatherInfo;

  bool _loading = false;

  bool get loading => _loading;
  Map<String, dynamic> get weatherInfo => _weatherInfo;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> getWeather(String cityName) async {
    setLoading(true);
    http.Response response = await http.get('$url?q=$cityName&appid=$key');
    setLoading(false);

    if (response.statusCode == 200) {
      print(response.statusCode);
      _weatherInfo = json.decode(response.body);
      notifyListeners();
      return true;
    } else {
      print(response.statusCode);
      print('Fail to get weather');
      notifyListeners();
      return false;
    }
  }
}