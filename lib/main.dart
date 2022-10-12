import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(
      title: 'Weather App',
     home: Home(),
));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   var temp;
   var description;
   var currently;
   var humidity;
   var windspeed;

   Future getWeather() async{
     http.Response response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=Boston&units=imperial&appid=af5906118fbfd752b6e140ed14ad8c32'));
     var result = jsonDecode(response.body);
     setState(() {
         this.temp = result['main']['temp'];
         this.description = result['weather'][0]['description'];
         this.currently = result['weather'][0]['main'];
         this.humidity = result['main']['humidity'];
         this.windspeed = result['wind']['speed'];


     });
   }
   @override
   void initState(){
     super.initState();
     this.getWeather();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Bostan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    currently != null ? currently.toString() :"Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Loading",),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("weather"),
                    trailing: Text(description != null ? description.toString():"Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString(): "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windspeed != null ? windspeed.toString():"Lodaing"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
