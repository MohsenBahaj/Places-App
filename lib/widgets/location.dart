// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import 'package:places/models/place.dart';
import 'package:places/screens/map.dart';

//AIzaSyCVbcE1aBJWd82PGxi2ondtAGg7kavyAfw
class LocationWidget extends StatefulWidget {
  final void Function(PlaceLocation location) onSelectLocation;
  const LocationWidget({
    Key? key,
    required this.onSelectLocation,
  }) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;
  bool isLoading = false;
  String get locationImage {
    if (_pickedLocation == null) {
      return "";
    }

    final lat = _pickedLocation!.lat;
    final address = _pickedLocation!.address;
    final long = _pickedLocation!.long;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$address&zoom=16&size=600x400&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$long&key=Enter your API key here.";
  }

  void savePlace(double lat, double lang) async {
    // final double lat = double.parse(lati);
    // final double long = double.parse(lang);
    final String _my_api = 'Enter your API key here.';
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lang&key=$_my_api');
    final respons = await http.get(url);
    final resData = json.decode(respons.body);
    final address = resData['results'][0]['formatted_address'];
    setState(() {
      _pickedLocation = PlaceLocation(lat: lat, long: lang, address: address);

      _isGettingLocation = false;
    });
    widget.onSelectLocation(_pickedLocation!);
  }

  void selectOnMap() async {
    setState(() {
      isLoading = true;
    });
    final LatLng? pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(),
      ),
    );
    if (pickedLocation == null) {
      return;
    }
    savePlace(pickedLocation.latitude, pickedLocation.longitude);
    setState(() {
      isLoading = false;
    });
  }

  void _getCurrentLocation() async {
    final String address;
    String _my_api = "Enter your API key here.";
    late double? lat;
    late double? long;
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();

    lat = locationData.latitude;
    long = locationData.longitude;
    if (lat == null || long == null) {
      print('error');
      return;
    }
    savePlace(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'No Location choosen',
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
    );
    if (_isGettingLocation) {
      setState(() {
        content = const Center(
          child: CircularProgressIndicator(),
        );
      });
    } else if (_pickedLocation != null) {
      content = Image.network(
        locationImage,
        height: double.infinity,
      );
    }
    return Column(
      children: [
        Container(
          child: Center(
            child: isLoading ? CircularProgressIndicator() : content,
          ),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          alignment: Alignment.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _getCurrentLocation();
                });
              },
              icon: Icon(Icons.location_on_outlined,
                  color: Theme.of(context).colorScheme.onSurface),
              label: Text(
                'Get current Location',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                selectOnMap();
              },
              icon: Icon(Icons.map_outlined,
                  color: Theme.of(context).colorScheme.onSurface),
              label: Text(
                'Select on Map',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            )
          ],
        )
      ],
    );
  }
}
