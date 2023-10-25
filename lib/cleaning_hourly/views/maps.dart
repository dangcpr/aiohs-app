import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rmservice/cleaning_hourly/controllers/mapsController.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen({super.key});

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  late GoogleMapController googleMapController;

  LatLng _center = LatLng(10.841645, 106.79091);

  late Set<Marker> markers;

  Position? _currentPosition;

  MapController mapController = MapController();

  late double latCurrent, lngCurrent;

  TextEditingController searchLocationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    markers = {
      Marker(
        markerId: MarkerId('Current Position'),
        position: _center,
      )
    };
  }

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 17.0,
            ),
            onCameraMove: (cameraPosition) async {
              //currentLongitude = cameraPosition.target.longitude; //gets the center longitude
              //currentLatitude = cameraPosition.target.latitude;

              setState(() {
                markers.clear();
                latCurrent = cameraPosition.target.latitude;
                lngCurrent = cameraPosition.target.longitude;
                markers.add(
                  Marker(
                    markerId: MarkerId('Current Position'),
                    position: LatLng(latCurrent, lngCurrent),
                  ),
                );
                FocusManager.instance.primaryFocus?.unfocus();
              });
            },
            onCameraIdle: () async {
              String? address = await MapController()
                  .convertLocationToAddress(latCurrent, lngCurrent);

              searchLocationController.text = address!;
              debugPrint(await MapController()
                  .convertLocationToAddress(latCurrent, lngCurrent));
            },
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(
                  controller: searchLocationController,
                  cursorColor: colorProject.primaryColor,
                  style: TextStyle(
                    fontFamily: fontApp,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorProject.primaryColor),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: () {
                        debugPrint('Search');
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _currentPosition = await mapController.determinePosition();

/*
            if (_currentPosition ==
                Future.error('Location permissions are denied')) {
              errorMessage('Location permissions are denied ', context);
              return;
            } else if (_currentPosition ==
                Future.error('Location services are disabled.')) {
              // ignore: use_build_context_synchronously
              errorMessage('Location services are disabled.', context);
              return;
            } else if (_currentPosition ==
                Future.error(
                    'Location permissions are permanently denied, we cannot request permissions.')) {
              errorMessage(
                  'Location permissions are permanently denied, we cannot request permissions.',
                  context);
              return;
            }
*/
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 15.0,
                target: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
              ),
            ),
          );

          debugPrint(_currentPosition!.latitude.toString() +
              ' ' +
              _currentPosition!.longitude.toString());

          debugPrint(await MapController().convertLocationToAddress(
              _currentPosition!.latitude, _currentPosition!.longitude));

          setState(() {
            markers.clear();
            markers.add(
              Marker(
                markerId: MarkerId('Current Position'),
                position: LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                ),
              ),
            );
            FocusManager.instance.primaryFocus?.unfocus();
          });
        },
        label: const Text('Get Location'),
        icon: const Icon(Icons.location_on),
      ),
    );
  }
}
