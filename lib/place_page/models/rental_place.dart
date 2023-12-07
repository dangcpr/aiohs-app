class RentalPlace {
  late String title;
  late int number_rental_days;
  late double area;
  late int price;
  late String description;
  late List<String> images;
  late String address;
  late double latitude;
  late double longitude;

  RentalPlace({
    required this.title,
    required this.number_rental_days,
    required this.area,
    required this.price,
    required this.description,
    required this.images,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  RentalPlace.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    number_rental_days = json['number_rental_days'];
    area = json['area'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'number_rental_days': number_rental_days,
    'area': area,
    'price': price,
    'description': description,
    'images': images,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
  };
}