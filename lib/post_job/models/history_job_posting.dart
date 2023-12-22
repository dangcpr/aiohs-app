class HistoryJobPosting {
  HistoryJobPosting({
    required this.code,
    required this.status,
    required this.statusDisplay,
    required this.userCode,
    required this.longitude,
    required this.latitude,
    required this.workingAddress,
    required this.title,
    required this.numberEmployee,
    required this.description,
    required this.wageType,
    required this.wageTypeDisplay,
    required this.wageMin,
    required this.wageMax,
    required this.images,
    required this.candidateGender,
    required this.candidateMinAge,
    required this.candidateMaxAge,
    required this.candidateExperience,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String code;
  late final String status;
  late final String statusDisplay;
  late final String userCode;
  late final double longitude;
  late final double latitude;
  late final String workingAddress;
  late final String title;
  late final int numberEmployee;
  late final String description;
  late final String wageType;
  late final String wageTypeDisplay;
  late final int wageMin;
  late final int wageMax;
  late final List<String> images;
  late final String candidateGender;
  late final int candidateMinAge;
  late final int candidateMaxAge;
  late final String candidateExperience;
  late final String createdAt;
  late final String updatedAt;

  HistoryJobPosting.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    statusDisplay = json['status_display'];
    userCode = json['user_code'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['status'] = status;
    _data['status_display'] = statusDisplay;
    _data['user_code'] = userCode;
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
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
