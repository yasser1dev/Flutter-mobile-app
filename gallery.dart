import 'package:flutter/material.dart';

import 'GalleryData.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String keyword="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${keyword}"),backgroundColor: Colors.deepOrangeAccent,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'keyword',
              ),
              onChanged: (value){
                setState(() {
                  this.keyword=value;
                });
              },
              onSubmitted: (value){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GalleryData(value)));
              },
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GalleryData(this.keyword)));
                },
                child: Text("search",style:TextStyle(fontSize: 22,color: Colors.white),),
                color: Colors.deepOrange,
              ),
            )
          ],

        ),
      ),
    );
  }
}
