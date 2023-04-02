import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

final Uri overpassApiURI = Uri.https('overpass-api.de', 'api/interpreter');

class OSMMarker extends Marker {
  String name;
  
  OSMMarker({required String name, required LatLng point, required double width, required double height, required builder})
      : 
      this.name = name,
      super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: width,
          width: height,
          point: point,
          builder: builder,
      );
}
class OsmItem {
  String name;
  double lat;
  double lon;
  Map<String, dynamic> tags;
  String recommendTag;

  OsmItem(this.name, this.lat, this.lon, this.tags, this.recommendTag);

  OSMMarker toMarker() => OSMMarker(
    name: this.name,
    point: LatLng(this.lat, this.lon),
    width: 80.0,
    height: 80.0,
    builder: (context) => const Icon(
      Icons.location_on,
      color: Color.fromRGBO(206, 147, 216, 1),
      size: 20,
    ),
  );

}

class OsmQuery {
  static Future<List<OsmItem>> queryNodesAround(int radius, double lat, double lon, Map<String, List<String>> tags) async {
    String body = "[out:json]; node(around:$radius, $lat, $lon)->.a; (";

    tags.forEach((tag, value) {
      value.forEach((element) {
        if (element == '*') {
          body += "node.a[name][$tag];";
        } else {
          body += "node.a[name][$tag=$element];";
        }
      });
    });

    body += "); out;";

    final Completer<List<OsmItem>> c = Completer();

    http.post(overpassApiURI, body: body).then((response) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      var items = data["elements"].map((x) {
        if (!x.containsKey("tags")) {
          log("dupsko");
        }

        String recommendTag = "";
        if (x["tags"].containsKey("sport")) {
          recommendTag = x["tags"]["sport"];
        }
        else if (x["tags"].containsKey("tourism")) {
          recommendTag = x["tags"]["tourism"];
        }
        else if (x["tags"].containsKey("amenity")) {
          recommendTag = x["tags"]["amenity"];
        }
        else if (x["tags"].containsKey("historic")) {
          recommendTag = x["tags"]["historic"];
        }

        recommendTag = recommendTag.split(';')[0];

        return OsmItem(
            x["tags"].containsKey("name") ? x["tags"]["name"] : "",
            x["lat"],
            x["lon"],
            x["tags"],
            recommendTag);
      }).toList();

      //for (var item in items) {
      //  log(item.recommendTag);
      //}

      c.complete(List<OsmItem>.from(items));
    });

    return c.future;
  }
}