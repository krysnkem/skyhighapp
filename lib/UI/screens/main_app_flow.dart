import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/providers/location_provider.dart';
import 'package:skyhighapp/UI/screens/app_needs_permission.dart';
import 'package:skyhighapp/UI/screens/home_page.dart';

class MainAppFlow extends StatelessWidget {
  const MainAppFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final locationPermission =
        context.select<LocationProvider, LocationPermission?>(
      (lcoationProvider) => lcoationProvider.locationPermission,
    );

    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever ||
        locationPermission == LocationPermission.unableToDetermine) {
      return const AppNeedPermission();
    }
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      return const MyHomePage(
        title: 'SkyHigh USA.',
      );
    }

    return const CheckingPermissions();
  }
}

class CheckingPermissions extends StatelessWidget {
  const CheckingPermissions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            Text('Checking permissions...'),
          ],
        ),
      ),
    );
  }
}
