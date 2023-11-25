class Product {
  String code;
  String name;
  String title;
  String type;
  String icon_url;
  String status;

  Product({
    required this.code,
    required this.name,
    required this.title,
    required this.type,
    required this.icon_url,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: json['code'],
      name: json['name'],
      title: json['title'],
      type: json['type'],
      icon_url: json['icon_url'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'title': title,
        'type': type,
        'icon_url': icon_url,
        'status': status,
      };
}
