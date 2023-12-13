class ExtractIDCard {
  late String full_name;
  late String identiny_no;
  late String issue_on;
  late String permanent_address;
  late String date_of_birth;
  late String place_of_birth;

  ExtractIDCard({
    required this.full_name,
    required this.identiny_no,
    required this.issue_on,
    required this.permanent_address,
    required this.date_of_birth,
    required this.place_of_birth
  });

  ExtractIDCard.fromJson(Map<String, dynamic> json) {
    full_name = json['name'];
    identiny_no = json['id'];
    issue_on = json['issue_date'];
    permanent_address = json['recent_location'];
    date_of_birth = json['birth_day'];
    place_of_birth = json['origin_location'];
  }

  Map<String, dynamic> toJson() => {
    'full_name': full_name,
    'identiny_no': identiny_no,
    'issue_on': issue_on,
    'permanent_address': permanent_address,
    'date_of_birth': date_of_birth,
    'place_of_birth': place_of_birth
  };
}