class User {
  String? code;
  String? full_name;
  String? email;
  String? phone_number;
  String? role;
  String? default_address;
  String? status;
  String? status_display;
  DateTime? created_at;
  DateTime? updated_at;

  User({
    this.code,
    this.full_name,
    this.email,
    this.phone_number,
    this.role,
    this.default_address,
    this.status,
    this.status_display,
    this.created_at,
    this.updated_at,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      code: json['code'],
      full_name: json['full_name'],
      email: json['email'],
      phone_number: json['phone_number'],
      role: json['role'],
      default_address: json['default_address'],
      status: json['status'],
      status_display: json['status_display'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'full_name': full_name,
      'email': email,
      'phone_number': phone_number,
      'role': role,
      'default_address': default_address,
      'status': status,
      'status_display': status_display,
      'created_at': created_at!.toIso8601String(),
      'updated_at': updated_at!.toIso8601String(),
    };
  }
}
