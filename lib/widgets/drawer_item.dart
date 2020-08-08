import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String name;
  final IconData icon;
  DrawerItem({this.name, this.icon});
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
          child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 30,
            color: Colors.teal[200],
          ),
          SizedBox(width: 20),
          Text(
            name,
            style: TextStyle(fontSize: 18),
          ),
        ],
      )),
    );
  }
}
