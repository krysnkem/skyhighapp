import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skyhighapp/providers/provider_collection.dart';
import 'package:skyhighapp/resources/app_palette.dart';
import 'package:skyhighapp/widgets/screens/main_app_flow.dart';
import 'widgets/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final locationPermission = await Geolocator.checkPermission();
  if (locationPermission == LocationPermission.denied ||
      locationPermission == LocationPermission.unableToDetermine) {
    await Geolocator.requestPermission();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppProviderCollection(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: AppPalette.greenmaterial),
          useMaterial3: true,
        ),
        home: const MainAppFlow(),
      ),
    );
  }
}
