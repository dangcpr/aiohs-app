import 'dart:io';

class ProductBuy {
  late final String name;
  late final List<File> listImages;

  ProductBuy({required this.name, required this.listImages});

  ProductBuy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    listImages = json['listImages'];
  }
}
