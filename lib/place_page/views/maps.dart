import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/mapsController.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ChooseLocationScreenPlace extends StatefulWidget {
  const ChooseLocationScreenPlace({super.key});

  @override
  State<ChooseLocationScreenPlace> createState() =>
      _ChooseLocationScreenPlaceState();
}

class _ChooseLocationScreenPlaceState extends State<ChooseLocationScreenPlace> {
  late GoogleMapController googleMapController;

  LatLng _center = LatLng(10.841645, 106.79091);

  late Set<Marker> markers;

  Position? _currentPosition;

  MapController mapController = MapController();

  late double latCurrent, lngCurrent;

  TextEditingController searchLocationController = TextEditingController();

  bool isSearch = false;

  Address addressObject = Address();

  bool isOnCameraMove = true;

  @override
  void initState() {
    super.initState();
    markers = {
      Marker(
        markerId: MarkerId('Current Position'),
        position: _center,
      )
    };
    latCurrent = _center.latitude;
    lngCurrent = _center.longitude;
  }

  //dispose
  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    //controller.setMapStyle(Utils.mapStyles)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Location'),
        actions: [
          TextButton(
            onPressed: () {
              // if (isSearch) {
              //   context.read<SaveAddressCubit>().state!.address = searchLocationController.text;
              //   context.read<SaveAddressCubit>().state!.shortAddress = addressObject.shortAddress;
              //   showModalBottomSheet(
              //     context: context,
              //     isScrollControlled: true,
              //     builder: (builder) {
              //       return BottomSheetAddress(isDarkMode: isDarkMode, lat: latCurrent, lng: lngCurrent);

              //     },
              //   );
              // } else
              //   null;
              context.read<SaveAddressCubit>().setAddress(addressObject);
              Navigator.pop(context);
            },
            child: Text(
              "Chọn",
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger,
                color: isSearch ? colorProject.primaryColor : Colors.grey,
              ),
            ),
          )
        ],
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
            onLongPress: (cameraPosition) {
              setState(() {
                isOnCameraMove = true;
              });
              debugPrint("On Long Press Map");
            },
            onCameraMove: (cameraPosition) {
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
              if (!isOnCameraMove) return;
              String? address = await MapController()
                  .convertLocationToAddress(latCurrent, lngCurrent);

              searchLocationController.text =
                  jsonDecode(address!)['formatted_address']!;

              List<dynamic> addressComponents =
                  jsonDecode(address)['address_components'];

              addressObject = Address(
                address: jsonDecode(address)['formatted_address'],
                shortAddress: jsonDecode(address)['address_components'][0]
                        ['long_name'] +
                    ' ' +
                    jsonDecode(address)['address_components'][1]['long_name'],
                latitude: latCurrent,
                longitude: lngCurrent,
                name: context.read<UserCubit>().state.full_name,
                phone: context.read<UserCubit>().state.phone_number,
                district: addressComponents.firstWhere((entry) => entry['types']
                    .contains('administrative_area_level_2'))['long_name'],
                city: addressComponents.firstWhere((entry) => entry['types']
                    .contains('administrative_area_level_1'))['long_name'],
              );

              // debugPrint(await MapController()
              //     .convertLocationToAddress(latCurrent, lngCurrent));

              setState(() {
                isSearch = true;
              });
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
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        debugPrint('Search');
                        String? detailAddress = await MapController()
                            .convertAddressToLocation(
                                searchLocationController.text);
                        markers.clear();
                        markers.add(
                          Marker(
                            markerId: MarkerId('Current Position'),
                            position: LatLng(
                              jsonDecode(detailAddress!)['geometry']['location']
                                  ['lat'],
                              jsonDecode(detailAddress)['geometry']['location']
                                  ['lng'],
                            ),
                          ),
                        );
                        searchLocationController.text =
                            jsonDecode(detailAddress)['formatted_address'];
                        FocusManager.instance.primaryFocus?.unfocus();

                        googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              zoom: 15.0,
                              target: LatLng(
                                jsonDecode(detailAddress)['geometry']
                                    ['location']['lat'],
                                jsonDecode(detailAddress)['geometry']
                                    ['location']['lng'],
                              ),
                            ),
                          ),
                        );
                        String? address = await MapController()
                            .convertLocationToAddress(latCurrent, lngCurrent);
                        List<dynamic> addressComponents =
                            jsonDecode(address!)['address_components'];

                        addressObject = Address(
                          address:
                              jsonDecode(detailAddress)['formatted_address'],
                          shortAddress: jsonDecode(detailAddress)['name'],
                          latitude: latCurrent,
                          longitude: lngCurrent,
                          name: context.read<UserCubit>().state.full_name,
                          phone: context.read<UserCubit>().state.phone_number,
                          district: addressComponents.firstWhere((entry) =>
                              entry['types'].contains(
                                  'administrative_area_level_2'))['long_name'],
                          city: addressComponents.firstWhere((entry) =>
                              entry['types'].contains(
                                  'administrative_area_level_1'))['long_name'],
                        );

                        setState(() {
                          isSearch = true;
                          // isOnCameraMove = false;
                        });
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      isSearch = false;
                    });
                  },
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

          // debugPrint(await MapController().convertLocationToAddress(
          //     _currentPosition!.latitude, _currentPosition!.longitude));

          setState(() {
            isOnCameraMove = true;
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
