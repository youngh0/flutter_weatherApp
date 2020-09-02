import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
//import 'package:info_weather/provider/counter.dart';
import 'package:login_firebase/provider/weather.dart';

//void main() => runApp(MyApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider<Counter>.value(value: Counter()),
        ChangeNotifierProvider<Weather>.value(value: Weather()),
      ],
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: Colors.indigo),
            //MyCounter(),
            //MyButtons(),
            //Divider(color: Colors.black),
            SizedBox(
              height: 30,
            ),
            MyWeather(),
          ],
        ),
      ),
    );
  }
}

class MyWeather extends StatefulWidget {
  @override
  _MyWeatherState createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  bool _autovalidate = false;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  _submit(Weather weather) {
    final form = _formKey.currentState;

    if (form.validate()) {
      final cityName = _locationController.text;
      print(cityName);
      weather.getWeather(cityName);
    } else {
      _autovalidate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var weather = Provider.of<Weather>(context);

    var mainWeatherDesc = weather.weatherInfo == null
        ? ''
        : weather.weatherInfo['weather'][0]['main'];
    final Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      autovalidate: _autovalidate,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 90.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
                labelText: 'City',
                hintText: 'Enter Location to watch for',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),

              child: Positioned(
                left: size.width*0.1,
                right: size.width*0.1,
                child: RaisedButton(
                  onPressed: () {
                    _submit(weather);
                  },

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: weather.loading
                      ? SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(),
                  )
                      : Text(
                    'Get Weather',
                  ),
                  color: Colors.indigoAccent,
                  textColor: Colors.white,

                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            if (mainWeatherDesc.length > 0)
              Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.indigoAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          children: <Widget>[
                            Text(_locationController.text + '의 온도',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            if (mainWeatherDesc == 'Clear')
                              Text(
                                weather.weatherInfo['main']['temp'].toString() +
                                    '℃☀︎',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            if (mainWeatherDesc == 'Rain')
                              Text(
                                weather.weatherInfo['main']['temp'].toString() +
                                    '℃☔︎︎',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            if (mainWeatherDesc != 'Clear' &&
                                mainWeatherDesc != 'Rain')
                              Text(
                                weather.weatherInfo['main']['temp'].toString() +
                                    '℃☁︎︎︎',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    //color: Colors.white,
                    width: double.infinity,

                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            buildWeatherText(mainWeatherDesc),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildTempText(weather),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildFeelTempText(weather),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildMaxTempText(weather),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildHumidityText(weather),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildPressureText(weather),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildWindSpeedText(weather),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              Container(
                //child: Text("이런 값은 없다!!"),
              )
          ],
        ),
      ),
    );
  }

  Row buildWindSpeedText(Weather weather) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Icon(Icons.toys),
        ),
        Text(
          " 풍속",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
//        Padding(
//          padding: EdgeInsets.only(left: 200),
//        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            weather.weatherInfo['wind']['speed'].toString() + 'km/h',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row buildPressureText(Weather weather) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(Icons.arrow_downward),
        ),
        Text(
          " 기압",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            weather.weatherInfo['main']['pressure'].toString() + ' mb',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row buildHumidityText(Weather weather) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(Icons.invert_colors),
        ),
        Text(
          " 습도",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            weather.weatherInfo['main']['humidity'].toString() + '%',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row buildMaxTempText(Weather weather) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(Icons.wb_sunny),
        ),
        Text(
          " 최고 온도",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            weather.weatherInfo['main']['temp_max'].toString() + '℃',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row buildFeelTempText(Weather weather) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(Icons.wb_sunny),
        ),
        Text(
          " 체감 온도",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            weather.weatherInfo['main']['feels_like'].toString() + '℃',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row buildTempText(Weather weather) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(Icons.wb_sunny),
        ),
        Text(
          " 현재 온도",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            weather.weatherInfo['main']['temp'].toString() + '℃',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row buildWeatherText(mainWeatherDesc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(
            Icons.cloud_queue,
            //color: Colors.black,
          ),
        ),
        Text(
          ' 날씨',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            mainWeatherDesc,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
