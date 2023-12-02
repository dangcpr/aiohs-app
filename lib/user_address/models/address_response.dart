class AddressResponse {
  String type;
  String city;
  String district;
  String ward;
  String street_name;
  String house_no;
  double latitude;
  double longitude;
  String detail;
  bool is_default;

  AddressResponse({
    required this.type,
    required this.city,
    required this.district,
    required this.ward,
    required this.street_name,
    required this.house_no,
    required this.latitude,
    required this.longitude,
    required this.detail,
    required this.is_default
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      type: json['type'],
      city: json['city'],
      district: json['district'],
      ward: json['ward'],
      street_name: json['street_name'],
      house_no: json['house_no'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      detail: json['detail'],
      is_default: json['is_default']
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'city': city,
    'district': district,
    'ward': ward,
    'street_name': street_name,
    'house_no': house_no,
    'latitude': latitude,
    'longitude': longitude,
    'detail': detail,
    'is_default': is_default
  };
}