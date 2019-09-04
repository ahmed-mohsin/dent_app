import 'package:flutter/material.dart';
import 'ui_bottomnavbar.dart';
import 'myDravver.dart';
import 'AddComment.dart';
//import 'package:photo_view/photo_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';

//import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';
//import 'package:dent_app/navbarElments/home.dart';
import 'addCase.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class caseBody extends StatefulWidget {
  @override
  _caseBodyState createState() => _caseBodyState();
}

class _caseBodyState extends State<caseBody> {
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
                "Cases Gallary",
                style: TextStyle(color: Colors.white),
              )),
          floatingActionButton: SizedBox(
              child: FloatingActionButton(
                  backgroundColor: Colors.grey.shade50,
                  child: Icon(
                    Icons.add,
                    color: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCase()),
                    );
                  })),
          drawer: Mydrawer(),
          body: new CaseBody(),
          bottomNavigationBar: BottomnavBar()),
    );
  }
}

class CaseBody extends StatefulWidget {
  const CaseBody({
    Key key,
  }) : super(key: key);

  @override
  _CaseBodyState createState() => _CaseBodyState();
}

class _CaseBodyState extends State<CaseBody> {
  double fontsize = 12;
  var _activelikeColor = Colors.grey;
  String like_text = "Like";
  bool likebool;
  var ref = Firestore.instance.collection('cases');
  var postId;
  var v_profileimage;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade100,
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('cases')
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Text(
                  "Loading",
                  style: TextStyle(fontSize: 25),
                ));
              }
              //var casedata = snapshot.data;
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot caseSnapshot =
                        snapshot.data.documents[index];


                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          '${caseSnapshot['profileimg']}'),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${caseSnapshot['username']}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black,
                                          )),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, top: 3),
                                        child: Text(
                                          '${caseSnapshot['date']}',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    var snack = SnackBar(
                                      content: Text(
                                          "click delete to delete the post"),
                                      action: SnackBarAction(
                                          label: "delete ",
                                          onPressed: () {
                                            Firestore.instance.runTransaction(
                                                (Transaction
                                                    myTransaction) async {
                                              await myTransaction.delete(
                                                  snapshot.data.documents[index]
                                                      .reference);
                                            });
                                          }),
                                    );
                                    Scaffold.of(context).showSnackBar(snack);
                                  })
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .50,
                            child: Image(
                              image: NetworkImage('${caseSnapshot['img']}'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8, top: 4, right: 8),
                            child: Text(
                              '${caseSnapshot['description']}',
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
                                        onPressed: () {
                                          setState(() {
                                            bool getLikebool =
                                            caseSnapshot['Likebool'];
                                            print(getLikebool);
                                            likebool = getLikebool;
                                            switch (likebool) {
                                              case false:
                                                {
                                                  caseSnapshot.reference
                                                      .updateData({
                                                    'likes':
                                                    caseSnapshot['likes'] +
                                                        1,
                                                    'Likebool': true
                                                  });
                                                  _activelikeColor =
                                                      Colors.teal;
                                                  fontsize = 13.0;
                                                }
                                                break;
                                              case true:
                                                {
                                                  caseSnapshot.reference
                                                      .updateData({
                                                    'likes':
                                                    caseSnapshot['likes'] -
                                                        1,
                                                    'Likebool': false
                                                  });
                                                  _activelikeColor =
                                                      Colors.grey;
                                                  fontsize = 12.0;
                                                }
                                                break;
                                            /*default :{
                                                caseSnapshot.reference.updateData({
                                                  //'likes':caseSnapshot['likes']+1,
                                                  'Likebool':false
                                                });
                                                //_activelikeColor= Colors.grey;
                                                //fontsize=12.0;
                                              }*/
                                            }
                                          });
                                        }

                                        //setState(() {});

                                        ,
                                        child: Text(
                                            '${caseSnapshot['likes'].toString()}' +
                                                ' likes',
                                            style: TextStyle(
                                              fontSize: fontsize,
                                              color: _activelikeColor,
                                            )),
                                      )),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: FlatButton(
                                    onPressed: () {
                                      postId = snapshot
                                          .data.documents[index].documentID;
                                      print(postId);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddComment(postId)),
                                      );
                                    },
                                    child: Text(
                                        '${caseSnapshot['comments'].toString()}' +
                                            ' comments',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => builder(),
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: FlatButton(
                                        onPressed: () {
                                          Share.share(
                                            "${caseSnapshot['img']}" +
                                                "\n \n ${caseSnapshot['description']}" +
                                                "        \n\n  Text form DentApp" +
                                                "\n \n for more please visit filgoal.com",
                                          );
                                        },
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
                            height: 3,
                            child: Container(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }));
  }
}

/*PhotoView(customSize: Size.fromHeight(300),
                                imageProvider: NetworkImage('${caseSnapshot['img']}'),
                                backgroundDecoration:
                                    BoxDecoration(color: Colors.white),
                                //enableRotation: true,
                              ))*/

Widget builder() {
  return Builder(
    builder: (BuildContext context) {
      AlertDialog(
          title: Text("hello"),
          elevation: 2,
          backgroundColor: Colors.deepOrange);
    },
  );
}


