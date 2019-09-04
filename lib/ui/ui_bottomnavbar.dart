import 'package:flutter/material.dart';


class BottomnavBar extends StatelessWidget {
  const BottomnavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BottomNavigationBar(fixedColor: Colors.teal,
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
              title: Text("library",style: TextStyle(color: Colors.teal))),
          BottomNavigationBarItem(
              backgroundColor: Colors.teal,
              icon: Icon(Icons.search,size: 25,color: Colors.teal),
              title: Text("search",style: TextStyle(color: Colors.teal),)),
        ],
        //fixedColor: Colors.black,
      ),
    );
  }
}
