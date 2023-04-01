// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hacknarok2023/osm_query.dart';
import 'package:hacknarok2023/user_profile.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'popup.dart';
class LiveMap extends StatefulWidget {
  @override
  _LiveMapState createState() => _LiveMapState();
}

class _LiveMapState extends State<LiveMap> {

  List<OsmItem> items = [];
  final PopupController _popupLayerController = PopupController();

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
        body: Column(
          children: [
          // child: 
          Expanded(
            // width: 200,
            // height: 200,
            flex: 3,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(50.06175, 19.93617),
                zoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                PopupMarkerLayerWidget(
                  options: PopupMarkerLayerOptions(
                    markerCenterAnimation: const MarkerCenterAnimation(),
                    markers: this.items.map((e) => e.toMarker()).toList(),
                    popupSnap: PopupSnap.markerCenter,//widget.snap,
                    popupController: _popupLayerController,
                    popupBuilder: (BuildContext context, Marker marker) =>
                        Popup(marker),
                    // markerRotate: widget.rotate,
                    // markerRotateAlignment:
                    //     PopupMarkerLayerOptions.rotationAlignmentFor(
                    //   widget.markerAnchorAlign,
                    // ),
                    // popupAnimation: const PopupAnimation.fade(
                    //         duration: Duration(milliseconds: 700)
                    // ),
                    markerTapBehavior: MarkerTapBehavior.togglePopupAndHideRest(),// widget.showMultiplePopups
                        // ? MarkerTapBehavior.togglePopup()
                        // : MarkerTapBehavior.togglePopupAndHideRest(),
                    onPopupEvent: (event, selectedMarkers) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(event.runtimeType.toString()),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(
          // height: 50,
          // ),
          Expanded(
            flex: 1,
            child: 
            Container(
              color: Colors.pink.shade200,
              width: 400,
              // height: 50,
              child: 
              Column(children: [
              // const SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(width: 50,),
                  IconButton(
              onPressed: () async {
                WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
                setState(() async {
                  var new_items = await OsmQuery.queryNodesAround(5000, 50.06175, 19.93617, {"sport": ["*"]});
                  setState(() {
                    this.items = new_items;
                  });
              });}, 
            icon: const Icon(Icons.search)),
              const Text('Recommendations:', style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold
            ), textAlign: TextAlign.center,),
            IconButton(
              onPressed: () {},
              // ),
            icon: const Icon(Icons.autorenew_rounded)),
              ],),
              // const SizedBox(
              //   height: 20,
              // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.sports_baseball),
              Text("    Sport"),
            ],),
              const SizedBox(
                height: 20,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.theater_comedy_sharp),
              Text("    Culture"),
            ],),
              const SizedBox(
                height: 20,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.church),
              Text("    History"),
            ],),
            ],)
            ),
            
            )]
        ),
      );
  }
}