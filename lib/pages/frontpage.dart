import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Menu extends StatefulWidget{
    const Menu({super.key, menu});
    @override
    MenuState createState()=> MenuState();
  }


  class MenuState extends State<Menu>{

        String _weather = '';
        String _delhiweather ='';

        @override
        void initState() {
          super.initState();
          fetchWeather();
        }

        Future<void> fetchWeather() async {
          final apiKey = '352385539 my api key form openweathermap.org';
          final city = 'Guwahati';
          final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
          final delhiurl = 'https://api.openweathermap.org/data/2.5/weather?q=Delhi&appid=$apiKey&units=metric';

          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            final temp = data['main']['temp'];
            final description = data['weather'][0]['description'];
            setState(() {
              _weather = 'Current temperature in $city is $temp°C\n$description';
            });
          } else {
            setState(() {
              _weather = 'Failed in loading Weather maybe outside is too stormy or its the end of the world';
            });
          }

          final delhiresponse = await http.get(Uri.parse(delhiurl));
          if (delhiresponse.statusCode == 200) {
            final delhidata = jsonDecode(delhiresponse.body);
            final delhitemp = delhidata['main']['temp'];
            final delhidescription = delhidata['weather'][0]['description'];
            setState(() {
              _delhiweather = 'Current temperature in Delhi is $delhitemp°C\n$delhidescription';
            });
          } else {
            setState(() {
              _delhiweather = 'Failed in loading Weather maybe outside is too stormy or its the end of the world';
            });
          }

        }

        @override
        Widget build(BuildContext context){
          return Scaffold(
            appBar: AppBar(
              title:const Text('Weathering'),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0,3),
                      ),
                    ]
                  ),
                  child:  Text(_weather,
                    textAlign: TextAlign.center,
                    ),
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    _delhiweather,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }
      }