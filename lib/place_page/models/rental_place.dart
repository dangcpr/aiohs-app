class RentalPlace {
  late String title;
  late int number_rental_days;
  late double area;
  late double price;
  late String description;
  late List<String> images;
  late String address;
  late double latitude;
  late double longitude;
  late double height;
  late bool has_elevator;
  late bool on_the_floors;
  late String city;
  late String district;
  late String ward;

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
    required this.height,
    this.has_elevator = false,
    this.on_the_floors = false,
    required this.city,
    required this.district,
    required this.ward,
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
    height = json['height'];
    on_the_floors = json['on_the_floors'];
    has_elevator = json['has_elevator'];
    city = json['city'];
    district = json['district'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'number_rental_days': number_rental_days,
        'area': area,
        'price': price,
        'description': description,
        'images': images,
        'address': address,
        'longitude': longitude,
        'latitude': latitude,
        'height': height,
        'on_the_floors': on_the_floors,
        'has_elevator': has_elevator,
        'city': city,
        'district': district,
        'ward': ward,
      };
}
