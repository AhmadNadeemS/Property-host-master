import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class ChoseOnMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Property Host'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.0,
            child: Stack(
              children: <Widget>[
                new FlutterMap(
                    options: new MapOptions(
                        minZoom: 10.0,
                        center: new LatLng(33.692705, 73.047778)),
                    layers: [
                      new TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c']),
                      new MarkerLayerOptions(markers: [
                        new Marker(
                            width: 45.0,
                            height: 45.0,
                            point: new LatLng(33.692705, 73.047778),
                            builder: (context) => new Container(
                                  child: IconButton(
                                      icon: Icon(Icons.place),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/ImageCarousel');
                                      }),
                                ))
                      ]),
                    ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
