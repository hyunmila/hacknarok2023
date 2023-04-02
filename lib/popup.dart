// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'user.dart';
import 'osm_query.dart';

class Popup extends StatefulWidget {
  final dynamic marker;

  const Popup({required this.user, required this.marker, Key? key}) : super(key: key);
  final user;
  @override
  State<StatefulWidget> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  
  void _incrementVisited(markername){
    setState(() {
      widget.user.visitedList.add(markername);
      widget.user.push();
    });
  }
  void _incrementFavourite(markername){
  setState(() {
    widget.user.favouriteList.add(markername);
    widget.user.push();
  });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: 
      
        Container(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 200, minHeight: 50, maxHeight: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _cardDescription(context),
        ]
        ),
        )
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.marker.name,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Row(
              children: [
              IconButton(
                tooltip: 'Add to visited places',
                onPressed: () {_incrementVisited(widget.marker.name);},
              icon: Icon(Icons.add_box_outlined)),
              IconButton(
                tooltip: 'Add to favourite places',
                onPressed: (){_incrementFavourite(widget.marker.name);}, 
              icon: Icon(Icons.favorite)),
            ],),
          ],
        ),
      ),
    );
  }
}