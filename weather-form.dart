import 'package:flutter/material.dart';
import 'package:tp_test_1/weather.dart';

class WeatherForm extends StatefulWidget {
  @override
  _WeatherFormState createState() => _WeatherFormState();
}

class _WeatherFormState extends State<WeatherForm> {
  String city;
  TextEditingController cityEditingController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${city}'),backgroundColor: Colors.deepOrangeAccent,),
      body: Column(
        children: <Widget>[
          Container(
              child: Padding(
                padding:const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Taper une ville'),
                  controller: cityEditingController,
                  onChanged: (String str){
                    setState(() {
                      city=str;
                    });
                  },
                  onSubmitted: (String str){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Weather(city)));
                    cityEditingController.text="";
                  },
                ),
              )
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: RaisedButton(
              child: Text('Search for weather',style: TextStyle(fontSize: 22,color: Colors.white),),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Weather(city)));
                cityEditingController.text="";
              },
              color: Colors.deepOrangeAccent,
            ),
          )
        ],
      ),
    );
  }
}
