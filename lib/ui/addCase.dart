import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddCase extends StatefulWidget {
  @override
  _AddCaseState createState() => _AddCaseState();
}

class _AddCaseState extends State<AddCase> {
  String addType = "piccase" ;
  String tf = "";
  File image;
  String filename,iu;
  bool subtnstate ;



  Future _getImageFromGalray() async {
    var selectedImage =
        await ImagePicker.pickImage(source: ImageSource.gallery);
uploadImage();
    setState(() {
      image = selectedImage;
      filename = basename(image.path);
uploadImage();
    }
    );
  }
  Future uploadImage() async{

    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
//reference.putFile(image);
StorageUploadTask uploadTask = ref.putFile(image);
var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();
var imageUrl=downurl.toString();
iu=imageUrl;
print(iu);


setState(() {
  iu ==null ? subtnstate=true : subtnstate=false ;

});
print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.teal,
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 25, bottom: 8),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            height: 100,
                            child: Text("choose pic from camera or gallary"),
                            onPressed: _getImageFromGalray,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width*.6,
                            child: image == null ?
                            Text("pick  image from gallary")
                                : Image.file(
                                    image,fit: BoxFit.fill,
                                    height: 150,
                                    width: MediaQuery.of(context).size.width*.6,
                                  )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("insert description"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 19),
                        child: TextField(
                          onChanged: (text) {
                            tf = text;
                          },
                          maxLines: 4,
                          decoration: InputDecoration.collapsed(

                              border: OutlineInputBorder(
                                gapPadding: 30
                                  ,borderSide: BorderSide(
                                      color: Colors.teal,
                                      style: BorderStyle.solid)),
                              hintText: "",
                              fillColor: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(

                    onEditingComplete: (){},
                    decoration: InputDecoration(border: OutlineInputBorder(gapPadding: 3.3),hintText: ""),)
                  ,Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MaterialButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.teal,
                          height: 35,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      MaterialButton(
                          child:  Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.teal,
                          height: 35,
                          onPressed: () {
                            if (iu!=null){
                            uploadImage();
                            //String url = ;
                                //"https://firebasestorage.googleapis.com/v0/b/dent-app-944c6.appspot.com/o/GettyImages-661014074-5ae65a18fa6bcc0036d1b35e.jpg?alt=media&token=612e975c-a729-438d-b80a-1d3e0f76545f";
                            setState(() {

                              if (addType== "piccase"){
                                Firestore.instance
                                    .collection('cases')
                                    .document()
                                    .setData({
                                  'comments': 0,
                                  'date': "25 march 2019",
                                  'description': "$tf",
                                  'img': iu,
                                  'likes': 0,
                                  'profileimg':
                                  'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/29790066_10213650742716130_1554565954052238420_n.jpg?_nc_cat=110&_nc_ht=scontent-hbe1-1.xx&oh=1b748153f3c52a24656718cc26d1fcf3&oe=5D3C4AFE',
                                  'username': "Ahmed Mohsin"
                                });
                              }

                              Navigator.pop(context);
                              print("upload done");
                            });}
                            else if (iu==null){
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("vvait till image upload")));}
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}