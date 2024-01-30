class MaidRes {
  late String code;
  late String name;
  late String email;
  late String phone_number;
  late String avatar_url;
  late num total_rating;
  late num avg_star;
  late double longitude;
  late double latitude;
  late String address;
  late num distance;

  MaidRes({
    required this.code,
    required this.name,
    required this.email,
    required this.phone_number,
    required this.avatar_url,
    required this.total_rating,
    required this.avg_star,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.distance
  });

  MaidRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    email = json['email'];
    phone_number = json['phone_number'];
    avatar_url = json['avatar_url'];
    total_rating = json['total_rating'];
    avg_star = json['avg_star'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    distance = json['distance'] ==  0 ? 0.0 : json['distance'];
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'email': email,
    'phone_number': phone_number,
    'avatar_url': avatar_url,
    'total_rating': total_rating,
    'avg_star': avg_star,
    'longitude': longitude,
    'latitude': latitude,
    'address': address,
    'distance': distance
  };
}