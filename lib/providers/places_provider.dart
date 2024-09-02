import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/models/place.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class UserPlcaesNotifier extends StateNotifier<List<Place>> {
  UserPlcaesNotifier() : super(const []);
  Future<sql.Database> _getDatabase() async {
    final dbpath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbpath, 'place.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image Text, lat REAL,lang REAL,address TEXT)');
      },
      version: 1,
    );
    return db;
  }

  Future<void> loadPlaces() async {
    final sql.Database db = await _getDatabase();

    final List<Map<String, Object?>> data = await db.query('user_places');
    final List<Place> places = data
        .map((row) => Place(
            id: row['id'] as String,
            image: File(row['image'] as String),
            title: row['title'] as String,
            location: PlaceLocation(
                lat: row['lat'] as double,
                long: row['lang'] as double,
                address: row['address'] as String)))
        .toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    if (!await Directory(appDir.path).exists()) {
      await Directory(appDir.path).create(recursive: true);
    }
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    print(copiedImage.path);
    final newPlace =
        Place(title: title, image: copiedImage, location: location);
    //-------------------------sql-------------------------
    try {
      final sql.Database db = await _getDatabase();
      db.insert('user_places', {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': copiedImage.path,
        'lat': newPlace.location.lat,
        'lang': newPlace.location.long,
        'address': newPlace.location.address,
      });
    } catch (e) {
      print('ERRROROROOROROOROR=$e');
    }

    state = [newPlace, ...state];
  }

  readPlaces() {
    return state;
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlcaesNotifier, List<Place>>(
  (ref) => UserPlcaesNotifier(),
);
