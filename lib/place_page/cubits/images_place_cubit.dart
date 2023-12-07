import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesPlaceCubit extends Cubit<List<File>> {
  ImagesPlaceCubit() : super(List.empty());

  void setImages(List<File> images) {
    debugPrint(images.length.toString());
    emit(images);
  }
}