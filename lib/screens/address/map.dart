import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/components/map-with-marker.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/models/lat-lng.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';

import 'add-address.dart';

class MapScreen extends StatefulWidget {
  final num initialLat;
  final num initialLng;

  MapScreen({this.initialLat, this.initialLng});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  num latitude, longitude;
  bool isLoading = false;
  String googlePlaceFormattedAddress, googlePlaceArea;

  @override
  void initState() {
    super.initState();
  }

  _done() {
    print("aaa");
    Navigator.push(context, ScaleTransationRoute(page: AddAddressScreen()));
    // setState(() => isLoading = true);
    // final coordinates = new Coordinates(latitude, longitude);
    // List<Address> addresses;
    // String city, district, address, area;
    // if (googlePlaceFormattedAddress != null) {
    //   try {
    //     addresses =
    //         await Geocoder.google("AIzaSyB-zre1gZSbbXHdzyGeWNnjGRbtVFZYbNs")
    //             .findAddressesFromQuery(googlePlaceFormattedAddress);
    //     area = googlePlaceArea;
    //     address = "${addresses.first.adminArea} - $googlePlaceArea";
    //     city = addresses.first.adminArea;
    //   } on PlatformException catch (err) {
    //     print("geocoder exception error : ${err.message}");
    //   }
    // } else {
    //   addresses =
    //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //   area = addresses.first.locality;
    //   address = addresses.first.addressLine;
    //   city = addresses.first.adminArea;
    //   district = addresses.first.subLocality;
    //   setState(() => isLoading = false);
    // }
    // MapResponse mapResponse = MapResponse(
    //     lat: latitude,
    //     lng: longitude,
    //     city: city,
    //     district: district,
    //     address: address,
    //     countryCode: addresses.first.countryCode,
    //     area: area);
    // mapLocation = mapResponse;
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: General.modalAppBar(context: context),
      body: Stack(
        children: <Widget>[
          MapWithMarker(
            enableMyLocation: true,
            initialMapPosition: widget.initialLng != null
                ? MapLatLng(lat: widget.initialLat, lng: widget.initialLng)
                : null,
            marker: Icon(
              Icons.location_on,
              color: Color(0xFF20213d),
              size: 40.0,
            ),
          ),
          Positioned(
              bottom: 20.0,
              left: 100.0,
              right: 100.0,
              child: RoundButton(
                  verticalPadding: 18.0,
                  onPress: _done,
                  buttonTitle: !isLoading
                      ? General.buildTxt(
                          txt: "تأكيد العنوان",
                          color: Colors.white,
                          isBold: true)
                      : General.customThreeBounce(context,
                          color: Colors.white, size: 15.0)))
        ],
      ),
    );
  }
}
