class RentalPlaceRes {
  late String code;
  late String user_code;
  late String type;
  late String type_display;
  late String status;
  late String status_display;
  late String title;
  late int number_rental_days;
  late double area;
  late double price;
  late String description;
  late List<String> images;
  late String address;
  late double longitude;
  late double latitude;
  late double height;
  late bool has_elevator;
  late bool on_the_floors;
  late String city;
  late String district;
  late String ward;

  RentalPlaceRes({
    required this.code,
    required this.user_code,
    required this.type,
    required this.type_display,
    required this.status,
    required this.status_display,
    required this.title,
    required this.number_rental_days,
    required this.area,
    required this.price,
    required this.description,
    required this.images,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.height,
    this.has_elevator = false,
    this.on_the_floors = false,
    required this.city,
    required this.district,
    required this.ward,
  });

  RentalPlaceRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    user_code = json['user_code'];
    type = json['type'];
    type_display = json['type_display'];
    status = json['status'];
    status_display = json['status_display'];
    title = json['title'];
    number_rental_days = json['number_rental_days'];
    area = json['area'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    height = json['height'];
    has_elevator = json['has_elevator'];
    on_the_floors = json['on_the_floors'];
    city = json['city'];
    district = json['district'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'user_code': user_code,
        'type': type,
        'type_display': type_display,
        'status': status,
        'status_display': status_display,
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
        'has_elevator': has_elevator,
        'on_the_floors': on_the_floors,
        'city': city,
        'district': district,
        'ward': ward,
      };
}
