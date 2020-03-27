import 'package:flutter/material.dart';
import 'package:tp_test_1/camera.dart';
import 'package:tp_test_1/gallery.dart';
import 'package:tp_test_1/weather-form.dart';
import 'package:tp_test_1/weather.dart';
import './quiz.dart';
import './gallery.dart';
import './camera.dart';
import './weather.dart';
import 'QRScan.dart';
void main() => runApp(MaterialApp(
  title: "App",
  home: MyApp(),
));

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       drawer:Drawer(
         child:ListView(
           children: <Widget>[
             DrawerHeader(
               decoration: BoxDecoration(
                 gradient:LinearGradient(colors: [Colors.deepOrange,Colors.white])
               ),
               child:Center(
                 child: CircleAvatar(
                   radius: 50,
                   backgroundImage: NetworkImage('https://scontent.frba1-1.fna.fbcdn.net/v/t1.0-1/p240x240/67262787_2369605196416587_4332129771111579648_n.jpg?_nc_cat=101&_nc_sid=dbb9e7&_nc_ohc=ezLof3fcGZ4AX8tJBKz&_nc_ht=scontent.frba1-1.fna&_nc_tp=6&oh=556259643902ce3775c55e45370bdc61&oe=5E95AC5C'),
                 ),
               )
             ),
             ListTile(
               title:Text('Quiz',style:TextStyle(fontSize: 20)),
               onTap:(){
                 Navigator.of(context).pop();
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>Quiz(7)));
               } ,

             ),
             Divider(color: Colors.deepOrange),
             ListTile(
               title:Text('Weather',style:TextStyle(fontSize: 20)),
               onTap:(){
                 Navigator.of(context).pop();
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>WeatherForm()));
               } ,
             ),
             Divider(color: Colors.deepOrange),
             ListTile(
               title:Text('Gallerie',style:TextStyle(fontSize: 20)),
               onTap:(){
                 Navigator.of(context).pop();
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>Gallery()));
               } ,
             ),
             Divider(color: Colors.deepOrange),

             ListTile(
               title:Text('Camera',style:TextStyle(fontSize: 20)),
               onTap:(){
                 Navigator.of(context).pop();
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>Camera()));
               } ,
             ),
             Divider(color : Colors.deepOrange),
             ListTile(
               title:Text('QR code',style:TextStyle(fontSize: 20)),
               onTap:(){
                 Navigator.of(context).pop();
                 Navigator.push(context,MaterialPageRoute(builder:(context)=>QRScan()));
               }
             )


           ],
         )
       ),
       appBar: AppBar(
           title:Text('MY FLutter Application'),
           backgroundColor: Colors.deepOrange),

       body: Center(
         child:Text('Welcome to my Flutter App',style: TextStyle(fontSize: 28),),
       )
     );
  }

}