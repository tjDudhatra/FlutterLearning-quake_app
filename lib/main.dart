import 'package:earthquake_app/util/data_fetcher.dart';
import 'package:flutter/material.dart';

import './ui/home.dart';

void main() async {
  runApp(MaterialApp(
    home: Home(await init()),
    title: "Quakes App",
  ));
}

Future<List> init() async {
  DataFetcher dataFetcher = new DataFetcher();
  return dataFetcher.getRequiredDataForList();
}
