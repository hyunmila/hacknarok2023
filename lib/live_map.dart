// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hacknarok2023/osm_query.dart';
import 'package:hacknarok2023/user_profile.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'popup.dart';
import 'user.dart';
import 'recommend.dart';
class LiveMap extends StatefulWidget {
  const LiveMap({required this.user, super.key});
  final user;
  @override
  _LiveMapState createState() => _LiveMapState();
}

class _LiveMapState extends State<LiveMap> {

  List<OsmItem> items = [];
  final PopupController _popupLayerController = PopupController();
  final MapController _mapController = MapController();
  List<String> recommended = ['-', '-', '-'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.grey.shade800,
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
            flex: 5,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(50.06175, 19.93617),
                zoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://api.mapbox.com/styles/v1/firebite/cjrax9zr50s9d2tkieemekyzk/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmlyZWJpdGUiLCJhIjoiY2tsamU3ZWJ5MDczZTJxcDV2b2xwNDA1ciJ9.qLGhpgroGtPyBo35rvVb0w',
                  // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                PopupMarkerLayerWidget(
                  options: PopupMarkerLayerOptions(
                    markerCenterAnimation: const MarkerCenterAnimation(),
                    markers: this.items.map((e) => e.toMarker()).toList(),
                    popupSnap: PopupSnap.markerCenter,//widget.snap,
                    popupController: _popupLayerController,
                    popupBuilder: (BuildContext context, Marker marker) =>
                        Popup(user: widget.user,marker: marker),
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
            flex: 2,
            child: 
            Container(
              color: Colors.pink.shade200,
              width: 1000,
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
                await OsmQuery.queryNodesAround(5000, _mapController.center.latitude, _mapController.center.longitude, {"sport": ["*"]}).then((new_items) {
                  setState(() {
                      this.items = new_items;
                  });
                });
                },
            icon: const Icon(Icons.search,
            color: Color.fromRGBO(66, 66, 66, 1))),
              const Text('Recommendations:', style: TextStyle(
                color: Color.fromRGBO(66, 66, 66, 1),
              fontSize: 17,
              fontWeight: FontWeight.bold
            ), textAlign: TextAlign.center,),
            IconButton(
              onPressed: () {
                setState(() {
                  print(this.recommended);
                  
                  this.recommended = getRecommended(this.items.map<String>((e) => e.name).toSet(), widget.user.visitedList) as List<String>;
                });
              },
              // ),
            icon: const Icon(Icons.autorenew_rounded,
            color: Color.fromRGBO(66, 66, 66, 1))),
              ],),
              // const SizedBox(
              //   height: 20,
              // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              IconButton(onPressed: (){},
                icon: Icon(Icons.sports_baseball), 
                color: Color.fromRGBO(66, 66, 66, 1)),
              Text("     " + this.recommended[0]),
            ],),
              // const SizedBox(
              //   height: 20,
              // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Icon(Icons.theater_comedy_sharp, color: Color.fromRGBO(66, 66, 66, 1)),
              // Text("     " + this.recommended[1]),
              IconButton(onPressed: (){},
                icon: Icon(Icons.theater_comedy_sharp), 
                color: Color.fromRGBO(66, 66, 66, 1)),
              Text("     " + this.recommended[1]),
            ],),
              // const SizedBox(
              //   height: 20,
              // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Icon(Icons.church, color: Color.fromRGBO(66, 66, 66, 1)),
              // Text("     " + this.recommended[2]),
                IconButton(onPressed: (){},
                icon: Icon(Icons.church), 
                color: Color.fromRGBO(66, 66, 66, 1)),
              Text("     " + this.recommended[2]),
            ],),
            ],)
            ),
            
            )]
        ),
      );
  }
}