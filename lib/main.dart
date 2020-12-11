import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "flutter",
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            SearchMapPlaceWidget(
              hasClearButton: true,
              placeType: PlaceType.address,
              placeholder: 'Search',
              apiKey: 'AIzaSyCp6yP-gzhvlWdh_VY68WoKiObfwR3BoF8',
              onSelected: (Place place) async {
                Geolocation geolocation = await place.geolocation;
                mapController.animateCamera(
                    CameraUpdate.newLatLng(geolocation.coordinates));
                mapController.animateCamera(
                    CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                height: 600.0,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController googleMmapController) {
                    setState(() {
                      mapController = googleMmapController;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                      zoom: 12.0, target: LatLng(-0.1813805, -78.4800729)),
                  mapType: MapType.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
