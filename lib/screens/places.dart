import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/models/place.dart';
import 'package:places/providers/places_provider.dart';
import 'package:places/screens/add_place.dart';
import 'package:places/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _ConsumerPlacesScreenState();
}

class _ConsumerPlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placeFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placeFuture = ref.read(userPlaceProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final List<Place> placesList = ref.watch(userPlaceProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => AddPlaceScreen()));
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: FutureBuilder(
            future: _placeFuture,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : PlacesList(places: placesList)));
  }
}
