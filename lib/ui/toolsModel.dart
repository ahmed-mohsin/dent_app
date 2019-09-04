import 'package:flutter/material.dart';
import 'ui_bottomnavbar.dart';
import 'myDravver.dart';

class toolBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white70.withAlpha(240),
          appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "tool Gallary",
                style: TextStyle(color: Colors.white),
              )),
          floatingActionButton: SizedBox(
              child: FloatingActionButton(
                  backgroundColor: Colors.grey.shade50,
                  child: Icon(
                    Icons.add,
                    color: Colors.teal,
                  ),
                  onPressed: () {})),
          drawer: Mydrawer(),
          body: new toolsBody(),
          bottomNavigationBar: BottomnavBar()),
    );
  }
}

class toolsBody extends StatelessWidget {
  const toolsBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          smalltool(),
          smalltool(),
          smalltool(),
          smalltool(),
          smalltool(),
          smalltool()
        ],
      ),
    );
  }
}

Widget smalltool() {
  return Container(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/am.jpg'),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(" Ahmed Mohsin  ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 5,top: 3),
                  child: Text("21 April 2019",style: TextStyle(color: Colors.grey,fontSize: 12),),
                )
              ],
            ),
          ],
        ),

        //Container(height: 300,child: Image(image: AssetImage("assets/vv.jpg"),fit: BoxFit.fill,),),
        /*Container(
            height: 300,
            child: PhotoView(
              imageProvider: AssetImage("assets/dt.jpg"),
              backgroundDecoration: BoxDecoration(color: Colors.white),
              //enableRotation: true,

            )),*/
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "These tools allow dental professionals to manipulate tissues for better visual access during treatment or during dental examination. Mirror. Probes. Operative burs. Excavators. Fine scalers. Curettes. Removable prosthodontics .. ",
            textAlign: TextAlign.justify,
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text("250 likes ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.teal,
                          )),
                    )),
              ),
              InkWell(
                onTap: () {},
                child: FlatButton(
                  onPressed: () {},
                  child: Text("50 Comments",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      )),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text("Share",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          )),
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    ),
  );
}
