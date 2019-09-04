import 'package:dent_app/auth/getdatafromsharedpref.dart';
import 'package:dent_app/navbarElments/bookmarks.dart';
import 'package:dent_app/navbarElments/profile.dart';
import 'package:dent_app/navbarElments/search.dart';
import 'package:flutter/material.dart';
import 'ui_bottomnavbar.dart';
import 'myDravver.dart';
import 'package:dent_app/navbarElments/home.dart';
import 'tutorailModel.dart';
import 'listv-item-fromtutos.dart';
import 'casesModel.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  int _currentIndex =0 ;
  Widget callpage(int curntIndex){
    switch(curntIndex){
      case 0 : return Mybody();
      case 1 : return profileActivity();
      case 2 : return bookmarksActivity();
      case 3 : return searchActivity();

      break;
      default : return Mybody();


    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/myapp': (BuildContext context) => new MyApp(),
        '/tutbody': (BuildContext context) => new Tutbody(),
        '/casebody': (BuildContext context) => new caseBody(),
      },
      home: Scaffold(
          backgroundColor: Colors.white70.withAlpha(240),
          appBar: AppBar(
            backgroundColor: Colors.teal,
            elevation: 0.0,
            centerTitle: true,
            title: FlutterLogo(colors: Colors.grey),
          ),
          floatingActionButton: SizedBox(
              child: FloatingActionButton(
                  backgroundColor: Colors.grey.shade50,
                  child: Icon(
                    Icons.add,
                    color: Colors.teal,
                  ),
                  onPressed: () {
                  })),
          drawer: Mydrawer(),
          body: callpage(_currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (value){
            _currentIndex=value;
            setState(() {

            });
            },
            items: [

              BottomNavigationBarItem(
                  backgroundColor: Colors.grey.shade50,
                  icon: Icon(Icons.home,size: 15,color: Colors.teal),
                  title: Text("home",style: TextStyle(color: Colors.teal))),
              BottomNavigationBarItem(
                  backgroundColor: Colors.grey.shade50,
                  icon: Icon(Icons.person,size: 25,color: Colors.teal),
                  title: Text("profile",style: TextStyle(color: Colors.teal))),
              BottomNavigationBarItem(
                  backgroundColor: Colors.grey.shade50,
                  icon: Icon(Icons.book,size: 25,color: Colors.teal,),
                  title: Text("favorites"/*as bookmarks*/,style: TextStyle(color: Colors.teal))),
              BottomNavigationBarItem(
                  backgroundColor: Colors.grey.shade50,
                  icon: Icon(Icons.search,size: 25,color: Colors.teal),
                  title: Text("search",style: TextStyle(color: Colors.teal),)),
            ],)),
    );
  }

  @override
  void initState() {
    getuserID();
    getuserName();
    getuserProfileImage();
  }
}
