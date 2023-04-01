import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

final Uri overpassApiURI = Uri.https('overpass-api.de', 'api/interpreter');

class OsmItem {
  String name;
  double lat;
  double lon;
  Map<String, dynamic> tags;

  OsmItem(this.name, this.lat, this.lon, this.tags);

}

class OsmQuery {
  static Future<List<OsmItem>> queryNodesAround(int radius, double lat, double lon, Map<String, List<String>> tags) async {
    String body = "[out:json]; node(around:$radius, $lat, $lon)->.a; (";

    tags.forEach((tag, value) {
      value.forEach((element) {
        if (element == '*') {
          body += "node.a[$tag];";
        } else {
          body += "node.a[$tag=$element];";
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