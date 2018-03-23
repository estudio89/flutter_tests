import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MyMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Map',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Mapa'),
          leading: new IconButton(icon: new Icon(Icons.arrow_back), color: Colors.white, onPressed: (){
              Navigator.of(context).pop();
            })
        ),
        body: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(-20.261496, -40.267791),
            zoom: 15.0,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(-20.261496, -40.267791),
                  builder: (ctx) =>
                  new Container(
                    child: new IconButton(icon: new Icon(Icons.location_on), color: Colors.red, onPressed: () {
                      print('Click...');
                      showMarker(context);
                    }, iconSize: 35.0, tooltip: 'Casa do Rodrigo'),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/webview');
          },
          tooltip: 'Map',
          child: new Icon(Icons.add),
        )
      )
    );
  }
}

showMarker(BuildContext context) async {
  var dialog = new SimpleDialog(
      title: const Text('Casa do Rodrigo'),
      children: <Widget>[
        new SimpleDialogOption(
          onPressed: () { Navigator.of(context).pop(); },
          child: const Text('Ok'),
        )
      ],
    );

  showDialog(context: context, child: dialog);
}