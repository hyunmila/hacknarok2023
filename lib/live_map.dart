import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hacknarok2023/user_profile.dart';
import 'package:latlong2/latlong.dart';

class LiveMap extends StatefulWidget {
  @override
  _LiveMapState createState() => _LiveMapState();
}

class _LiveMapState extends State<LiveMap> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Maps', style: TextStyle(
          fontSize: 20), textAlign: TextAlign.center),
        backgroundColor: Colors.pink.shade200,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          IconButton(onPressed: () async{
            await Navigator.pushNamed(context, '/user');
            setState(() {
              
            });
          }, 
          icon: const Icon(Icons.person))
        ],
        ),
        body: Center(
          child: Expanded(
            // width: 200,
            // height: 200,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(45.5231, -122.6765),
                zoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://api.mapbox.com/styles/v1/firebite/cjrax9zr50s9d2tkieemekyzk/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmlyZWJpdGUiLCJhIjoiY2tsamU3ZWJ5MDczZTJxcDV2b2xwNDA1ciJ9.qLGhpgroGtPyBo35rvVb0w',
                  // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
              ],
            ),
          ),
        ),
      );
  }
}