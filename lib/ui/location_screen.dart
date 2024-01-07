import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/ui/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  int humidity = 0;
  int wind = 0;
  int maxTemp = 0;
  String weatherIcon = '';
  String cityName = '';
  String weatherMessage = '';
  int cWind = 0;
  int codeCondition = 0;
  String message = '';
  int minTemp = 0;
  int feelsLike = 0;
  int pressure = 0;
  int visibility = 0;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        wind = 0;
        maxTemp = 0;
        temperature = 0;
        humidity = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        codeCondition = 0;
        message = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      humidity = weatherData['main']['humidity'];

      double mTemp = weatherData['main']['temp_max'];
      maxTemp = mTemp.toInt();

      double miTemp = weatherData['main']['temp_min'];
      minTemp = miTemp.toInt();

      double feellike = weatherData['main']['feels_like'];
      feelsLike = feellike.toInt();

      double w = weatherData['wind']['speed'];
      wind = w.toInt();
      cWind = (wind * 3.6).toInt(); // m/s to km/h

      var condition = weatherData['weather'][0]['id'];
      codeCondition = condition;
      weatherIcon = getImageUrl(codeCondition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
      int cVis = weatherData['visibility'];
      visibility = (cVis / 1000).toInt();
      message = weatherData['weather'][0]['description'];
    });
  }

  String getImageUrl(int condition) {
    if (condition < 300) {
      return 'assets/thunderstorm.png';
    } else if (condition < 400) {
      return 'assets/lightrain.png';
    } else if (condition < 600) {
      return 'assets/heavyrain.png';
    } else if (condition < 700) {
      return 'assets/hail.png';
    } else if (condition < 800) {
      return 'assets/showers.png';
    } else if (condition == 800) {
      return 'assets/clear.png';
    } else if (condition <= 804) {
      return 'assets/lightcloud.png';
    } else {
      return 'assets/alarm.png';
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ByteBolt'),
        backgroundColor: Color(0xff0D2C54),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Color(0xff0D2C54),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Color(0xff0D2C54),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color(0xff0D2C54),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff0D2C54).withOpacity(0.5),
                        offset: const Offset(0, 25),
                        blurRadius: 12,
                        spreadRadius: -12,
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -40,
                        left: 20,
                        child: Image.asset(weatherIcon),
                        width: 150,
                      ),
                      Positioned(
                        bottom: 30,
                        left: 20,
                        child: Text(
                          capitalize(message),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                '$temperature' + '˚',
                                style: const TextStyle(
                                  fontSize: 90,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff449DD1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.06,
                            ),
                            Text(
                              cityName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xff449DD1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width * .8,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Wind Speed',
                              style: TextStyle(color: Color(0xff0D2C54)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xff78C0E0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Image.asset('assets/windspeed.png'),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '$cWind' + ' km/h',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Humidity',
                              style: TextStyle(color: Color(0xff0D2C54)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xff78C0E0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Image.asset('assets/humidity.png'),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '$humidity' + ' %',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Max Temperature',
                              style: TextStyle(color: Color(0xff0D2C54)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xff78C0E0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Image.asset('assets/max-temp.png'),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '$maxTemp' + '˚C',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Visibility',
                              style: TextStyle(color: Color(0xff0D2C54)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xff78C0E0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Image.asset('assets/visibility.png'),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '$visibility' + ' km',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Feels Like',
                              style: TextStyle(color: Color(0xff0D2C54)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xff78C0E0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Image.asset('assets/hail.png'),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '$feelsLike' + '˚C',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Min Temperature',
                              style: TextStyle(color: Color(0xff0D2C54)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xff78C0E0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Image.asset('assets/sleet.png'),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '$minTemp' + '˚C',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
