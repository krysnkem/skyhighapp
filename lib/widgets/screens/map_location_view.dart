import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/providers/map_provider.dart';

class MapLocationView extends StatefulWidget {
  const MapLocationView({super.key});

  @override
  State<MapLocationView> createState() => _MapLocationViewState();
}

class _MapLocationViewState extends State<MapLocationView> {
  late final GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    final currentPosition = context
        .select<MapProvider, LatLng>((provider) => provider.currentLatLng);

    return SafeArea(
      child: Stack(
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
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Align(
              alignment: Alignment.topCenter,
              child: SearchArea(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}

class SearchArea extends StatelessWidget {
  const SearchArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SearchField(),
        InkWell(
          onTap: () =>
              context.read<MapProvider>().moveCamertoCurrentUserLocation(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: PredictionItem(text: 'Go to your location'),
          ),
        ),
      ],
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _textFieldController;
  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'images/searchIcon.svg',
                      width: 24,
                    ),
                    Expanded(
                      child: TypeAheadField<Prediction?>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _textFieldController,
                          decoration: const InputDecoration(
                            isDense: false,
                            contentPadding: EdgeInsets.only(left: 20),
                            fillColor: Color(0xffF2F2F2),
                            hintText: "Enter location",
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                        onSuggestionSelected: (suggestion) {
                          _textFieldController.text =
                              suggestion?.structuredFormatting?.mainText ?? "";
                          context
                              .read<MapProvider>()
                              .onSuggestionSelected(suggestion);
                        },
                        itemBuilder: (context, itemData) {
                          if (itemData == null) {
                            return Container();
                          } else {
                            return PredictionItem(
                              text: itemData.structuredFormatting?.mainText ??
                                  itemData.description ??
                                  "",
                            );
                          }
                        },
                        suggestionsCallback: (pattern) => context
                            .read<MapProvider>()
                            .getListOfPredictions(text: pattern),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            TextButton(
              onPressed: () {
                _textFieldController.clear();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: const Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}

class PredictionItem extends StatelessWidget {
  const PredictionItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          SvgPicture.asset(
            'images/locationPinIcon.svg',
            height: 20,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          )
        ],
      ),
    );
  }
}
