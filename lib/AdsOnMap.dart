
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:signup/services/PostAdCreation.dart';


class AdsOnMap extends StatefulWidget {
  @override
  _AdsOnMap createState() => _AdsOnMap();

}
  class _AdsOnMap extends State<AdsOnMap> {

  String token = 'sk.eyJ1IjoibWF3YWlzIiwiYSI6ImNraGJvMnlhMTAwMG8yeG5vNXdlY2w2aTYifQ.maEiJc8WGc_0c1nZuWWeyQ';
  final String style = 'mapbox://styles/mapbox/streets-v11';

 // MapboxMapController _mapController;
  Stream cordinatesofAds;
 List <GeoPoint> cordinates = List<GeoPoint>();
  LatLng _center = LatLng(33.640348, 72.993679);
  var infoWindowVisible = false;


  List<Marker> allmarkers = List<Marker>();


  @override
  void initState(){
   getLatlongOfAds();
  }

  @override
  void dispose(){
    super.dispose();
}
  getLatlongOfAds(){
    PostAddFirebase().getCordinatesOfAds().then((snapshots){
      setState(() {
        cordinatesofAds = snapshots;
        print(
            "we got the data + ${cordinatesofAds.toString()}");
      });
    });
  }
  Widget _buildMap() {
    return  StreamBuilder(
        stream: cordinatesofAds,
        builder: (context,snapshot){

                if (!snapshot.hasData) return Text('Loading maps...Please Wait');
                 for (int i =0; i<snapshot.data.documents.length; i++) {
                   double lat = snapshot.data.documents[i]['Location'].latitude;
                   double lng = snapshot.data.documents[i]['Location'].longitude;
                   debugPrint(lng.toString());

                   allmarkers.add(new Marker(
                     point:new LatLng(lat,lng),
                     width: 279.0,
                     height: 256.0,
                     builder: (context) =>
                         GestureDetector(
                             onTap: () {
                               debugPrint("Tapp tapp loot ka no mazak");

                             },
                             child: _buildCustomMarker()),
                   ));
                     }
                return FlutterMap(
                    options: new MapOptions(

                      center: _center,
                      interactive: true,
                    ),
                    layers: [
                      new TileLayerOptions(
                          urlTemplate:
                          "https://api.mapbox.com/styles/v1/mawais/ckhbnqs160ohy19kbat8opzj3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWF3YWlzIiwiYSI6ImNraGE2bHhkaDA5MDAydHJzMGMxZG1jeWkifQ.K_7JYzNOsuRLWyOhiw7EJQ",
                          additionalOptions: {
                            'accessToken':token,
                            'id': 'mapbox.mapbox-streets-v8'
                          }),
                      new MarkerLayerOptions(
                          markers: allmarkers
                      ),
                    ]);
              }
        );


  }


  /*List<Marker> _buildMarkersOnMap() {

    List<Marker> markers = List<Marker>();

    for (int i =0; i<cordinates.length; i++) {
      double lat = cordinates[i].latitude;
      double lng = cordinates[i].longitude;

      var marker = new Marker(
        point:new LatLng(lat,lng),
        width: 279.0,
        height: 256.0,
        builder: (context) =>
            GestureDetector(
                onTap: () {

                },
                child: _buildCustomMarker()),
      );
      markers.add(marker);

    }
     return markers;

   }*/



  Stack _buildCustomMarker() {
    return Stack(
      children: <Widget>[marker()],
    );
  }


  Opacity marker() {
    return Opacity(
      child: Container(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/images/pin.png',
            width: 49,
            height: 65,
          )),
      opacity: infoWindowVisible ? 0.0 : 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[600],
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Property Host'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
      ),
      body: _buildMap(),
    );
     /* body: StreamBuilder(
        stream: cordinatesofAds,
        builder: (context,snapshot){
          return ListView.builder(itemCount: snapshot.data.documents.length,
              shrinkWrap: true,
            itemBuilder: (context, index){
                return Container(
                  width: 100,
                  height: 300,
                  child: MapboxMap(
                  accessToken: token,
                  styleString: style,

          initialCameraPosition: CameraPosition(
          zoom: 10.0,
          target: LatLng(33.684422, 73.047882),
          ),
         onMapCreated: (MapboxMapController controller) async {
          final result = snapshot.data.documents[index].data["Location"];
          debugPrint(result.toString());
          await controller.animateCamera(
            CameraUpdate.newLatLng(result),
          );

          await controller.addCircle(
            CircleOptions(
              circleRadius: 8.0,
              circleColor: '#006992',
              circleOpacity: 0.8,
              geometry: result,
              draggable: true,
            ),
          );
        },
        // I'm using the onMapLongClick callback here, but there's also one for
        // a single tap, onMapClick, but heck, that's just for a tutorial
          onMapClick: (Point<double> point, LatLng coordinates) async {
          // Add a symbol (marker)
          await _mapController.addSymbol(
            SymbolOptions(
              // You retrieve this value from the Mapbox Studio
              iconImage: 'embassy-15',
              iconColor: '#006992',

              // YES, YOU STILL NEED TO PROVIDE A VALUE HERE!!!
              geometry: coordinates,
            ),
          );
        },

                ));
          });
        })*/

  }
 /* Future<LatLng> acquireCurrentLocation() async {
    // Initializes the plugin and starts listening for potential platform events
    Location location = new Location();

    // Whether or not the location service is enabled
    bool serviceEnabled;

    // Status of a permission request to use location services
    PermissionStatus permissionGranted;

    // Check if the location service is enabled, and if not, then request it. In
    // case the user refuses to do it, return immediately with a null result
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check for location permissions; similar to the workflow in Android apps,
    // so check whether the permissions is granted, if not, first you need to
    // request it, and then read the result of the request, and only proceed if
    // the permission was granted by the user
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    // Gets the current location of the user
    final locationData = await location.getLocation();
    return LatLng(locationData.latitude, locationData.longitude);
  }*/



}




