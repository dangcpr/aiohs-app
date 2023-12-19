import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesPlaceCubitForJobPosting extends Cubit<List<File>> {
  ImagesPlaceCubitForJobPosting() : super(List.empty());

  void setImages(List<File> images) {
    debugPrint(images.length.toString());
    emit(images);
  }

  void setInit() {
    emit(List.empty());
  }
}
