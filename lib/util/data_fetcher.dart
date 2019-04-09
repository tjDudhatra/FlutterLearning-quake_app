import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DataFetcher {
  static const String KEY_PLACE = "place";
  static const String KEY_TIME = "time";
  static const String KEY_MAG = "mag";
  static const String KEY_TITLE = "title";

  Future<List> getRequiredDataForList() async {
    Map allData = await fetchData();
    List<Map> requiredData = new List();

    List features = allData["features"];
    for (int i = 0; i < features.length; i++) {
      Map feature = features[i]["properties"];
      Map requiredDataMap = new Map();
      requiredDataMap.putIfAbsent(KEY_TITLE, () => feature[KEY_TITLE]);
      requiredDataMap.putIfAbsent(KEY_PLACE, () => feature[KEY_PLACE]);
      requiredDataMap.putIfAbsent(
          KEY_TIME, () => getReadableDate(feature[KEY_TIME]));
      requiredDataMap.putIfAbsent(KEY_MAG, () => feature[KEY_MAG]);

      requiredData.add(requiredDataMap);
    }

    return requiredData;
  }

  Future<Map> fetchData() async {
    final String apiUrl =
        "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  String getReadableDate(int dateTime) {
    return DateFormat("MMMM dd, yyyy hh:mm aaa")
        .format(DateTime.fromMillisecondsSinceEpoch(dateTime));
  }
}
