import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

final Uri overpassApiURI = Uri.https('overpass-api.de', 'api/interpreter');

class OsmItem {
  String name;
  double lat;
  double lon;
  Map<String, dynamic> tags;

  OsmItem(this.name, this.lat, this.lon, this.tags);

  Marker toMarker() => Marker(
    point: LatLng(this.lat, this.lon),
    width: 80,
    height: 80,
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
      var data = jsonDecode(response.body);

      var items = data["elements"].map((x) =>
        OsmItem(
          x["tags"].containsKey("name") ? x["tags"]["name"] : "",
          x["lat"],
          x["lon"],
          x["tags"])
      ).toList();

      c.complete(List<OsmItem>.from(items));
    });

    return c.future;
  }
}