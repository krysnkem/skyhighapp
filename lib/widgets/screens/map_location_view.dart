import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/providers/map_provider.dart';

class MapLocationView extends StatefulWidget {
  const MapLocationView({super.key});

  @override
  State<MapLocationView> createState() => _MapLocationViewState();
}

class _MapLocationViewState extends State<MapLocationView>
    with AutomaticKeepAliveClientMixin {
  late final GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final currentPosition = context
        .select<MapProvider, LatLng>((provider) => provider.currentLatLng);

    return Stack(
      children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          initialCameraPosition:
              CameraPosition(zoom: 16, target: currentPosition),
          onMapCreated: (controller) {
            _mapController = controller;
            context.read<MapProvider>().setMapController(controller);
          },
          markers: {
            Marker(
              markerId: const MarkerId("1"),
              position: currentPosition,
              icon: BitmapDescriptor.defaultMarker,
            ),
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
