import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/models/place.dart';
import 'package:places/screens/map.dart';

class PlaceDetail extends StatelessWidget {
  final Place place;

  const PlaceDetail({super.key, required this.place});
  String get locationImage {
    final lat = place.location.lat;
    final address = place.location.address;
    final long = place.location.long;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$address&zoom=16&size=600x400&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$long&key=Enter your API key here.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Container(
        child: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              height: 350,
              width: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => MapScreen(
                                  location: place.location,
                                  isSelecting: false,
                                )));
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(locationImage),
                        radius: 30,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.black54,
                              Colors.black,
                              Colors.black
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Text(
                        place.location.address,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
