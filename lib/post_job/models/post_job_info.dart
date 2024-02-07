class PostJobInfo {
  PostJobInfo({
    this.longitude,
    this.latitude,
    this.workingAddress,
    this.title,
    this.numberEmployee = 1,
    this.description,
    this.wageType,
    this.wageTypeDisplay = 'CASH',
    this.wageMin = 20000,
    this.wageMax = 30000,
    required this.images,
    this.candidateGender = 'male',
    this.candidateMinAge = 18,
    this.candidateMaxAge = 50,
    this.candidateExperience,
    this.city,
    this.district,
    this.ward,
  });
  late double? longitude;
  late double? latitude;
  late String? workingAddress;
  late String? title;
  late int numberEmployee;
  late String? description;
  late String? wageType;
  late String wageTypeDisplay;
  late double wageMin;
  late double wageMax;
  late List<String> images;
  late String candidateGender;
  late int candidateMinAge;
  late int candidateMaxAge;
  late String? candidateExperience;
  late String? city;
  late String? district;
  late String? ward;

  PostJobInfo.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
    workingAddress = json['working_address'];
    title = json['title'];
    numberEmployee = json['number_employee'];
    description = json['description'];
    wageType = json['wage_type'];
    wageTypeDisplay = json['wage_type_display'];
    wageMin = json['wage_min'];
    wageMax = json['wage_max'];
    images = List.castFrom<dynamic, String>(json['images']);
    candidateGender = json['candidate_gender'];
    candidateMinAge = json['candidate_min_age'];
    candidateMaxAge = json['candidate_max_age'];
    candidateExperience = json['candidate_experience'];
    city = json['city'];
    district = json['district'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['working_address'] = workingAddress;
    _data['title'] = title;
    _data['number_employee'] = numberEmployee;
    _data['description'] = description;
    _data['wage_type'] = wageType;
    _data['wage_type_display'] = wageTypeDisplay;
    _data['wage_min'] = wageMin;
    _data['wage_max'] = wageMax;
    _data['images'] = images;
    _data['candidate_gender'] = candidateGender;
    _data['candidate_min_age'] = candidateMinAge;
    _data['candidate_max_age'] = candidateMaxAge;
    _data['candidate_experience'] = candidateExperience;
    _data['city'] = city;
    _data['district'] = district;
    _data['ward'] = ward;
    return _data;
  }
}
