import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class GalleryData extends StatefulWidget {
  String value;
  @override
  _GalleryDataState createState() => _GalleryDataState();
  GalleryData(this.value);
}

class _GalleryDataState extends State<GalleryData> {
  //List<dynamic> data;
  int currentPage=1;
  int pageSize=10;
  int totalePages=0;
  ScrollController _scrollController=ScrollController();
  dynamic dataGallery;
  List<dynamic> hits=List();
  getData(url){
    http.get(url).then((resp){
      setState(() {
        dataGallery=jsonDecode(resp.body);
        hits.addAll(dataGallery['hits']);
        if(dataGallery['totalHits']%this.pageSize==0) {
          this.totalePages = dataGallery['totalHits'] ~/ this.pageSize;
        }
        else this.totalePages=1+(dataGallery['totalHits']/this.pageSize).floor();
      });
    }).catchError((err){
      print(err);
    });

  }

  void initState(){
    super.initState();
    this.loadData();
    this._scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent)
        if(currentPage<totalePages)
          setState(() {
            ++currentPage;
            print(currentPage);
            this.loadData();
          });

    });
  }
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }
  void loadData(){
    String url='https://pixabay.com/api/?key=5832566-81dc7429a63c86e3b707d0429&q=${widget.value}&page=$currentPage&per_page=$pageSize';
    print(url);
    getData(url);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.value} : $currentPage / $totalePages"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: (hits==null)?Center(
        child: CircularProgressIndicator()
      ):
        ListView.builder(itemCount:hits==null?0:hits.length,controller: _scrollController,
            itemBuilder: (context,index){
          return Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Text('${hits[index]['tags']}',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                        color: Colors.deepOrange,
                      ),
                      Image.network('${hits[index]['webformatURL']}'),
                    ],
                  )
                ],
              ),
            ),
          );
            })


    );
  }
}
