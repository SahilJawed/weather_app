import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = "London";  // Default city
  String apiKey = "9389832452a392af2f2b15c6df8050d0"; // Your OpenWeather API key
  double temperature = 0.0;
  String weatherCondition = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final url = "https://api.openweathermap.org/data/2.5/weather?q=Atlanta&appid=9389832452a392af2f2b15c6df8050d0&units=metric";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        temperature = data["main"]["temp"];
        weatherCondition = data["weather"][0]["main"];
      });
    } else {
      setState(() {
        weatherCondition = "Error fetching data";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(city, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            Text("${temperature.toStringAsFixed(1)}°C", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: Colors.white)),
            const SizedBox(height: 10),
            Text(weatherCondition, style: const TextStyle(fontSize: 24, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

