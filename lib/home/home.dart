import 'package:flutter/material.dart';
import 'package:weather/service/weather_dio.dart';
import 'package:weather/service/weather_response.dart';

class Home extends StatefulWidget {
  final double lat;
  final double lon;
  const Home({super.key, required this.lat, required this.lon});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherResponse? weatherResponse;
  bool isLoading = false;

  void toggleLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Image.asset(
                  "assets/image/night.jpg",
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 150),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          weatherResponse?.name ?? '',
                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                        const Text("today", style: TextStyle(color: Colors.white)),
                        Image.network(weatherResponse?.weather?[0].getWeatherIcon() ?? ''),
                        Text(
                          weatherResponse?.weather?[0].description ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          "${convertToCel(weatherResponse?.main?.temp ?? 0.0).toStringAsFixed(1)}°C",
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 30, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "Humidity",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "${weatherResponse?.main?.humidity.toString() ?? ''}%",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Wind",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "${weatherResponse?.wind?.speed.toString() ?? ''}Km/h",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Pressure", style: TextStyle(color: Colors.white)),
                                Text(
                                  weatherResponse?.main?.pressure.toString() ?? '',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void getData() async {
    toggleLoading(true);
    weatherResponse = await ApiService().getData(widget.lat, widget.lon);
    toggleLoading(false);
  }

  double convertToCel(num value) {
    return value - 273.15;
  }
}
