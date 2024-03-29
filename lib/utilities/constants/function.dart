import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:rmservice/utilities/constants/variable.dart';

List<OnbordingData> getOnbordingData(BuildContext context) {
  final List<OnbordingData> list = [
    OnbordingData(
      image: AssetImage("assets/images/SS-0.png"),
      titleText: Text(
        AppLocalizations.of(context)!.helloOBtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'GoogleSans-Bold',
          fontSize: 24,
          color: Color(0xFF00B27D),
        ),
      ),
      descText: Text(
        AppLocalizations.of(context)!.helloOBdesc,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'GoogleSans-Regular',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    ),
    OnbordingData(
      image: AssetImage("assets/images/SS-1.png"),
      titleText: Text(
        AppLocalizations.of(context)!.firstOBtitle,
        style: TextStyle(
          fontFamily: 'GoogleSans-Bold',
          fontSize: 24,
          color: Color(0xFF00B27D),
        ),
      ),
      descText: Text(
        AppLocalizations.of(context)!.firstOBdesc,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'GoogleSans-Regular',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    ),
    OnbordingData(
      image: AssetImage("assets/images/SS-2.png"),
      titleText: Text(
        AppLocalizations.of(context)!.secondOBtitle,
        style: TextStyle(
          fontFamily: 'GoogleSans-Bold',
          fontSize: 24,
          color: Color(0xFF00B27D),
        ),
      ),
      descText: Text(
        AppLocalizations.of(context)!.secondOBdesc,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'GoogleSans-Regular',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    ),
    OnbordingData(
      image: AssetImage("assets/images/SS-3.png"),
      titleText: Text(
        AppLocalizations.of(context)!.thirdOBtitle,
        style: TextStyle(
          fontFamily: 'GoogleSans-Bold',
          fontSize: 24,
          color: Color(0xFF00B27D),
        ),
      ),
      descText: Text(
        AppLocalizations.of(context)!.thirdOBdesc,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'GoogleSans-Regular',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    ),
  ];

  return list;
}

void errorMessage(String message, BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontFamily: fontApp),
        ),
        backgroundColor: Colors.red,
      ),
    ),
  );
}

void successMessage(String message, BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontFamily: fontApp),
        ),
        backgroundColor: Colors.green,
      ),
    ),
  );
}

Future<String> uploadImage(File file) async {
  try {
    final response = await cloudinary.upload(
      file: file.path,
      fileBytes: file.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: "/images",
      progressCallback: (count, total) {
        print('Uploading image from file with progress: $count/$total');
      },
    );

    if (response.isSuccessful) {
      return response.url!;
    } else {
      throw response.error!;
    }
  } catch (e) {
    debugPrint(e.toString());
    throw e.toString();
  }
}
