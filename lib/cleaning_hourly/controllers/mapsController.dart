import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:maps_places_autocomplete/model/suggestion.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MapController {
  Future<Position> determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        debugPrint('123');
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        debugPrint('7890');
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.whileInUse) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          debugPrint('456');
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        debugPrint('789');
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      debugPrint('Location successful!');
      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint('Something went wrong');
      return Future.error('Something went wrong');
    }
  }

  Future<String?> convertLocationToAddress(double lat, double lng) async {
    try {
      String mapApiKey = maps_api_key;

      String _host = 'https://maps.google.com/maps/api/geocode/json';

      final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';

      if (lat != null && lng != null) {
        var response = await http.get(Uri.parse(url));

        debugPrint(response.statusCode.toString());

        if (response.statusCode == 200) {
          Map data = jsonDecode(response.body);
          String _formattedAddress = data["results"][0]["formatted_address"];
          print("response ==== $_formattedAddress");
          return _formattedAddress;
        } else
          return null;
      } else
        return null;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Something went wrong');
    }
  }
/*
  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final client = Client();
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request as Uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
  */
}
