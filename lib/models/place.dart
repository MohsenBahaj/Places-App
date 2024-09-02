import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  Place(
      {String? id,
      required this.image,
      required this.title,
      required this.location})
      : id = id ?? uuid.v4();
}

class PlaceLocation {
  final double lat;
  final double long;
  final String address;

  const PlaceLocation({
    required this.lat,
    required this.long,
    required this.address,
  });
}
