import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/models/place.dart';
import 'package:places/providers/places_provider.dart';
import 'package:places/screens/place_details.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key, required this.places});
  final List<Place> places;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Place> places_list = ref.watch(userPlaceProvider);
    if (places_list.isEmpty) {
      return Center(
        child: Text('No places added yet',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                )),
      );
    }
    return ListView.builder(
        itemCount: places_list.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PlaceDetail(
                          place: places_list[index],
                        )));
              },
              title: Text(places_list[index].title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface)),
              leading: CircleAvatar(
                  radius: 16,
                  backgroundImage: FileImage(places_list[index].image)),
              subtitle: Text(places_list[index].location.address,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface)),
            ),
          );
        });
  }
}
