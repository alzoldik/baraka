import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:baraka/blocs/map-bloc.dart';
import 'package:baraka/models/changed-location.dart';
import 'package:baraka/models/lat-lng.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

const kGoogleApiKey = "AIzaSyB-zre1gZSbbXHdzyGeWNnjGRbtVFZYbNs";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapWithMarker extends StatefulWidget {
  final Widget marker;
  final bool enableMyLocation;
  final MapLatLng initialMapPosition;
  const MapWithMarker({
    this.marker,
    this.enableMyLocation = false,
    this.initialMapPosition,
  });

  @override
  State<MapWithMarker> createState() => MapWithMarkerState();
}

class MapWithMarkerState extends State<MapWithMarker> {
  Future<CameraPosition> _cameraInitialPosition;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final String markerIdVal = "MYMARKERID";
  String formattedAddress = "Search for places";
  String googlePlaceFormattedAddress;
  String googlePlaceArea;
  MapBloc mapBloc;
  @override
  void initState() {
    super.initState();
    googlePlaceFormattedAddress = null;
    _initializeCamera();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 100));
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == AppLifecycleState.resumed.toString()) {
        _initializeCamera();
        setState(() {});
      }
    });
  }

  void _initializeCamera() async {
    _cameraInitialPosition = _getUserLocation();
    if (widget.initialMapPosition != null) {
      geoToSpecificLocation(
          widget.initialMapPosition.lat, widget.initialMapPosition.lng);
    }
  }

  Future<CameraPosition> _getUserLocation() async {
    LocationManager.LocationData currentLocation;
    var location = new LocationManager.Location();
    try {
      if (await location.serviceEnabled()) {
        currentLocation = await location.getLocation();
        if (await location.hasPermission() != null) {
          mapBloc.setChangedLocation(
              location: ChangedLocation(
                  lat: currentLocation.latitude,
                  lng: currentLocation.longitude,
                  googlePlaceFormattedAddress: googlePlaceFormattedAddress,
                  googlePlaceArea: googlePlaceArea));

          return CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 15,
          );
        } else {
          throw Exception(
              ["Please turn on location permission for baraka app1"]);
        }
      } else {
        throw Exception(
            "Please turn on your location services to be able to serve you");
      }
    } catch (error) {
      print("an error occur :${error.toString()}");
      location.requestPermission();
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    mapBloc = Provider.of<MapBloc>(context);

    return Scaffold(
      body: FutureBuilder<CameraPosition>(
        future: _cameraInitialPosition,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  GoogleMap(
                    markers: Set<Marker>.of(markers.values),
                    myLocationEnabled: widget.enableMyLocation,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: snapshot.data,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      mapBloc.setIsMapCreated(val: true);
                    },
                    onCameraMove: (CameraPosition newPosition) {
                      mapBloc.setChangedLocation(
                          location: ChangedLocation(
                              lat: newPosition.target.latitude,
                              lng: newPosition.target.longitude,
                              googlePlaceFormattedAddress:
                                  googlePlaceFormattedAddress,
                              googlePlaceArea: googlePlaceArea));
                    },
                  ),
                  widget.marker != null
                      ? Positioned(
                          left: 0.0,
                          right: 0.0,
                          bottom: 0.0,
                          top: 0.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: widget.marker,
                          ),
                        )
                      : Container(),
                  Positioned(
                    left: 15.0,
                    right: 15.0,
                    top: 20,
                    child: handleSearchBtn(),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Permission is not grainted",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      AppSettings.openLocationSettings();
                    },
                    child: Text("Go To Location Settings"),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.my_location,
          size: 24.0,
        ),
        onPressed: _gotoMyLocation,
      ),
    );
  }

  _openPlacesScreen() async {
    try {
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: Mode.fullscreen,
        language: "en",
        // components: [Component(Component.country, "EG")],
      );
      print("my p is :$p");
      if (p != null) {
        showDetailPlace(p.placeId);
      }
    } catch (e) {
      print("google places error :$e");
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      PlacesDetailsResponse place =
          await _places.getDetailsByPlaceId(placeId, language: "en");
      var lat = place.result.geometry.location.lat;
      var lng = place.result.geometry.location.lng;
      mapBloc.setChangedLocation(
          location: ChangedLocation(
              lat: lat,
              lng: lng,
              googlePlaceFormattedAddress: place.result.formattedAddress,
              googlePlaceArea: place.result.name));
      geoToSpecificLocation(lat, lng);
    }
  }

  handleSearchBtn() {
    return InkWell(
      onTap: _openPlacesScreen,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(100.0)),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            General.sizeBoxHorizontial(10.0),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.62,
              child: General.buildTxt(
                  txt: formattedAddress,
                  color: Colors.grey,
                  isCenter: false,
                  fontSize: 12.0,
                  isOverflow: true),
            )
          ],
        ),
      ),
    );
  }

  Future<void> geoToSpecificLocation(lat, lng) async {
    CameraPosition locationPosition = CameraPosition(
      target: LatLng(lat, lng),
      tilt: 50.0,
      bearing: 45.0,
      zoom: 15.0,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(locationPosition));
  }

  Future<void> _gotoMyLocation() async {
    CameraPosition myLocationPosition = await _getUserLocation();
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(myLocationPosition));
  }
}
