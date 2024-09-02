// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place.dart';

class MapScreen extends StatefulWidget {
  MapScreen(
      {super.key,
      this.location =
          const PlaceLocation(lat: 37.422, long: -122.07, address: ''),
      this.isSelecting = true});
  final PlaceLocation location;
  bool isSelecting;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.isSelecting ? "Pick Your Location " : "Yout Location"),
          actions: [
            if (widget.isSelecting)
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(_selectedLocation);
                  },
                  icon: Icon(Icons.save)),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: GoogleMap(
            onTap: !widget.isSelecting
                ? null
                : (newLocation) {
                    setState(() {
                      _selectedLocation = newLocation;
                      print('Latitude: ${_selectedLocation!.latitude}');
                      print('Longitude: ${_selectedLocation!.longitude}');
                    });
                  },
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.location.lat, widget.location.long),
              zoom: 16,
            ),
            markers: (_selectedLocation == null && widget.isSelecting)
                ? {}
                : {
                    Marker(
                        markerId: MarkerId('x1'),
                        position: _selectedLocation ??
                            LatLng(widget.location.lat, widget.location.long)),
                  },
          ),
        ));
  }
}
