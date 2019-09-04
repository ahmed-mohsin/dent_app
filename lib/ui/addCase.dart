import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class AddCase extends StatefulWidget {
  @override
  _AddCaseState createState() => _AddCaseState();
}

class _AddCaseState extends State<AddCase> {
String imagUrl ;
String userName ;
  String addType = "piccase" ;
  String tf = "";
  File image;
  String filename,iu;
  bool subtnstate ;
int nnn ;

  Future postID() async {
    var respectsQuery = Firestore.instance
        .collection('cases');
    var querySnapshot = await respectsQuery.getDocuments();
    var totalposts = querySnapshot.documents.length;
    print("hello set state + $totalposts");
    nnn=totalposts+1;
    return nnn;
  }


  /*getPostNum() {
    var a=  Firestore.instance
        .collection('cases').snapshots();
    int numb = a.length as int   ;
    int numc = numb+1 ;
    return numc ;
  }*/


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
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAuth.instance.currentUser().then((firebaseUser){
      if(firebaseUser == null)
      {
        //signed out
      }
      else{
        print("succeful log in");
        userName = firebaseUser.displayName;
        imagUrl=firebaseUser.photoUrl;//signed in
      }
    });
    postID();
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
            child: ListView(
              children: <Widget>[
                Container(
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

                      Row(
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
                                if (iu!=null) {

                                  uploadImage();

                                setState(() {

                                  setDataToFirebase();

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
              ],
            ),
          ),
        ),
      ),
    );
  }


  void setDataToFirebase() {
    Firestore.instance
        .collection('cases')
        .document()
        .setData({

      //'postnum':nnn,
      //'uID':'am05042325252',
      'comments': 0,
      'Likebool': false,
      'date': "${getDateofnow()}",
      'description': "$tf",
      'img': iu,
      'likes': 0,
      'profileimg':imagUrl,
      'username': userName
    });
  }
}

String  getDateofnow(){
  var now = DateTime.now();
  //to write the name of the day write mmm ,,,, iif mm will write num
  var dateFormat = DateFormat('dd MMM yyyy  @ hh:mm').format(now);
  return dateFormat;
}


