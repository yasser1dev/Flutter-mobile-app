import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  String result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QRScan"),backgroundColor: Colors.blue,),
      body: Center(
        child: Text(result!=null?result:"QR Code Scanner",style: TextStyle(fontSize: 18),),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.scanner),
          onPressed: scanQR,
          label: Text('QR Scan')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future scanQR() async{
    try {
      String scanResult = await BarcodeScanner.scan();
      setState(() {
        result = scanResult;
      });
    }on PlatformException catch(e){
      if(e.code==BarcodeScanner.CameraAccessDenied){
        ackDialog(context,"Camera access denied");
      }
      else ackDialog(context, "Unknown error");
    }on FormatException catch(e){
      ackDialog(context, "You pressed the back button before scanning");

    }catch(e){
      ackDialog(context, "Other erros");
    }

}

Future<void> ackDialog(BuildContext context,String msg){
    return showDialog<void>(
      context: context,
      builder:( BuildContext context){
        return AlertDialog(
          title: Text("Alert !!!"),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }


    );
}

}
