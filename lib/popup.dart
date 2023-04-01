// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class Popup extends StatefulWidget {
  final Marker marker;

  const Popup(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  // final List<IconData> _icons = [
  //   Icons.star_border,
  //   Icons.star_half,
  //   Icons.star
  // ];
  // int _currentIcon = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: 
      
        Container(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 200, minHeight: 50, maxHeight: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          // Padding(
          //     padding: const EdgeInsets.only(left: 20, right: 10),
          //     // child: Icon(_icons[_currentIcon]),
          //   ),
            _cardDescription(context),
        ]),
        )
      
      // InkWell(
      //   onTap: () => setState(() {
      //     _currentIcon = (_currentIcon + 1) % _icons.length;
      //   }),
      //   child: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.only(left: 20, right: 10),
      //         child: Icon(_icons[_currentIcon]),
      //       ),
      //       _cardDescription(context),
      //     ],
      //   ),
      // ),
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
            const Text(
              'Place name',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            // Text(
            //   // 'Position: ${widget.marker.point.latitude}, ${widget.marker.point.longitude}',
            //   'Add to visited places',
            //   style: const TextStyle(fontSize: 12.0)),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
              IconButton(
                tooltip: 'Add to visited places',
                onPressed: (){

              }, icon: Icon(Icons.add_box_outlined)),
              IconButton(
                tooltip: 'Add to favourite places',
                onPressed: (){

              }, icon: Icon(Icons.favorite)),
            ],),
              
            // Text(
            //   'Add to favourite places',
            //   style: const TextStyle(fontSize: 12.0),
            // ),
          ],
        ),
      ),
    );
  }
}