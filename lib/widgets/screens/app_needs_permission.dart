import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/providers/location_provider.dart';

class AppNeedPermission extends StatelessWidget {
  const AppNeedPermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'App needs location permission enabled for full functionality',
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<LocationProvider>().requestPermission();
                    },
                    child: const Text("Grant Access"),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<LocationProvider>().openSettings();
                    },
                    child: const Text("Open Settings"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
