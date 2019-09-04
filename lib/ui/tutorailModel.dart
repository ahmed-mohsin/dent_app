import 'package:flutter/material.dart';
import 'ui_bottomnavbar.dart';
import 'myDravver.dart';
import 'package:dent_app/navbarElments/home.dart';
import 'listv-item-fromtutos.dart';

class Tutbody extends StatefulWidget {
  @override
  _TutbodyState createState() => _TutbodyState();
}

class _TutbodyState extends State<Tutbody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0.0,
          centerTitle: true,
          title: Text("Tutorial",style: TextStyle(color: Colors.white),)),
        body: Container(
          child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  conty(),
                  conty(),
                  conty(),
                  conty(),
                  conty(),
                  conty(),
                ],
              ),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            child: Icon(Icons.add),
            onPressed: () {



            }),
        drawer: Mydrawer(),
        bottomNavigationBar: BottomnavBar());
  }
}


/*Container(
                height: 70,
                color: Colors.white.withOpacity(0.8),

              ),*/