import 'package:earthquake_app/util/data_fetcher.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final List fetchedData;

  Home(this.fetchedData);

  @override
  State createState() {
    return HomeState(fetchedData);
  }
}

class HomeState extends State<Home> {
  final List fetchedData;

  HomeState(this.fetchedData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quakes App"),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: fetchedData != null ? fetchedData.length : 0,
          itemBuilder: (BuildContext context, int position) {
            return Column(
              children: <Widget>[
                Divider(height: 20),
                ListTile(
                    title: Text(
                      fetchedData[position][DataFetcher.KEY_TIME],
                      style: TextStyle(color: Colors.indigoAccent),
                    ),
                    subtitle: Text(
                      fetchedData[position][DataFetcher.KEY_PLACE],
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    leading: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Text(
                            "${fetchedData[position][DataFetcher.KEY_MAG]}"),
                        radius: 25),
                    onTap: () => showTapMessage(
                        context, fetchedData[position][DataFetcher.KEY_TITLE]))
              ],
            );
          }),
    );
  }

  void showTapMessage(final BuildContext context, final String message) {
    var alertDialog = new AlertDialog(
      title: Text("Earthquake"),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Dismiss"))
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }
}
