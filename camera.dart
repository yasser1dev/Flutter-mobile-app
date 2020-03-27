import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File imgFile=null;
  VisionText visionTextOcr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera"),backgroundColor: Colors.deepOrange,),
      body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: MaterialButton(
                  child: Text('Pick Image',style: TextStyle(color: Colors.white,fontSize: 22),),
                  color: Colors.blue,
                  onPressed: (){
                    openDialog(context);
                  },
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text('${visionTextOcr==null?'':visionTextOcr.text}'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit:BoxFit.cover,
                      image: (imgFile!=null)?FileImage(imgFile,):AssetImage("images/no-image-found.jpg"))
                    )
                  ),

                ),

            ],
          ),
        ),
      ),
    );
  }

  Future<VisionText> textOcr(File imageFile){
    final FirebaseVisionImage visionImage=FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer=FirebaseVision.instance.textRecognizer();
    final Future<VisionText> visionText=textRecognizer.processImage(visionImage);
    return visionText;
  }

  Future<void> openDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text('Pick an option'),
        actions: <Widget>[
          FlatButton(
            child: Text('Gallery'),
            onPressed: () async{
              Navigator.of(context).pop();
              var file=await ImagePicker.pickImage(source: ImageSource.gallery);
              File croppedFile=await ImageCropper.cropImage(sourcePath: file.path);
              VisionText visionText=await textOcr(croppedFile);
              setState(() {
                imgFile=file;
                visionTextOcr=visionText;
              });
            },
          ),
          FlatButton(
            child: Text('camera'),
            onPressed: () async{
              Navigator.of(context).pop();
              var file=await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 400,maxWidth: 400);
              File croppedFile=await ImageCropper.cropImage(sourcePath: file.path,);
              VisionText visionText=await textOcr(croppedFile);
              print(visionText.text);
              setState(() {
                imgFile=file;
                visionTextOcr=visionText;
              });
            },
          )
        ],
      );
    });
  }
}
