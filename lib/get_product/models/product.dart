import 'dart:convert';

class Product {
  String code;
  String name;
  String title;
  String price;
  String type;
  String icon_url;
  String status;
  // DateTime created_at;
  // DateTime created_by;
  // DateTime updated_at;
  String updated_by;

  Product({
    required this.code,
    required this.name,
    required this.title,
    required this.price,
    required this.type,
    required this.icon_url,
    required this.status,
    // required this.created_at,
    // required this.created_by,
    // required this.updated_at,
    required this.updated_by,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: json['code'],
      name: json['name'],
      title: json['title'],
      price: jsonEncode(json['price']),
      type: json['type'],
      icon_url: json['icon_url'],
      status: json['status'],
      // created_at: DateTime.parse(json['created_at']),
      // created_by: DateTime.parse(json['created_by']),
      // updated_at: DateTime.parse(json['updated_at']),
      updated_by: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'title': title,
        'price': price,
        'type': type,
        'icon_url': icon_url,
        'status': status,
        // 'created_at': created_at.toIso8601String(),
        // 'created_by': created_by.toIso8601String(),
        // 'updated_at': updated_at.toIso8601String(),
        'updated_by': updated_by,
      };
}
