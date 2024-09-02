import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/screens/places.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:places/widgets/places_list.dart';

final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 99, 8, 246),
    background: const Color.fromARGB(255, 57, 47, 68),
    brightness: Brightness.dark);
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
          titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
          titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      ),
      home: PlacesScreen(),
    );
  }
}
