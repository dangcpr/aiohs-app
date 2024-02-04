class ProvinceVN {
  late String provinceId;
  late String provinceName;
  late String provinceType;

  ProvinceVN({
    required this.provinceId,
    required this.provinceName,
    required this.provinceType,
  });

  Map<String, dynamic> toJson() => {
      'provinceId': provinceId,
      'provinceName': provinceName,
      'provinceType': provinceType,
  };

  factory ProvinceVN.fromMap(Map<String, dynamic> map) {
    return ProvinceVN(
      provinceId: map['province_id'],
      provinceName: map['province_name'],
      provinceType: map['province_type'],
    );
  }
}

class DistrictVN {
  late String districtId;
  late String districtName;
  late String districtType;
  late String? lat;
  late String? lng;
  late String provinceId;

  DistrictVN({
    required this.districtId,
    required this.districtName,
    required this.districtType,
    required this.lat,
    required this.lng,
    required this.provinceId,
  });

  Map<String, dynamic> toJson() => {
      'districtId': districtId,
      'districtName': districtName,
      'districtType': districtType,
      'lat': lat,
      'lng': lng,
      'provinceId': provinceId,
  };

  factory DistrictVN.fromMap(Map<String, dynamic> map) {
    return DistrictVN(
      districtId: map['district_id'],
      districtName: map['district_name'],
      districtType: map['district_type'],
      lat: map['lat'],
      lng: map['lng'],
      provinceId: map['province_id'],
    );
  }
}