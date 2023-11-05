class RentalPlace {
  late int id;
  late String name;
  late String phone;
  late String titleRent;
  late int numOfDayRent;
  late double area;
  late int price;
  late String description;
  late List<String> images;
  late String address;
  late double latitude;
  late double longitude;

  RentalPlace({
    required this.id,
    required this.name,
    required this.phone,
    required this.titleRent,
    required this.numOfDayRent,
    required this.area,
    required this.price,
    required this.description,
    required this.images,
    required this.address,
    required this.latitude,
    required this.longitude
  });

  RentalPlace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    titleRent = json['titleRent'];
    numOfDayRent = json['numOfDayRent'];
    area = json['area'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'titleRent': titleRent,
    'numOfDayRent': numOfDayRent,
    'area': area,
    'price': price,
    'description': description,
    'images': images,
    'address': address,
    'latitude': latitude,
    'longitude': longitude
  };
}