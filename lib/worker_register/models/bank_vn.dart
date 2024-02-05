class BankVN {
  late int id;
  late String name;
  late String code;
  late String bin;
  late String shortName;
  late String logo;
  late int transferSupported;
  late int lookupSupported;
  late String short_name;
  late int support;
  late int isTransfer;
  late String? swift_code;

  BankVN({
    required this.id,
    required this.name,
    required this.code,
    required this.bin,
    required this.shortName,
    required this.logo,
    required this.transferSupported,
    required this.lookupSupported,
    required this.short_name,
    required this.support,
    required this.isTransfer,
    required this.swift_code,
  });

  BankVN.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    bin = json['bin'];
    shortName = json['shortName'];
    logo = json['logo'];
    transferSupported = json['transferSupported'];
    lookupSupported = json['lookupSupported'];
    short_name = json['short_name'];
    support = json['support'];
    isTransfer = json['isTransfer'];
    swift_code = json['swift_code'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
        'bin': bin,
        'shortName': shortName,
        'logo': logo,
        'transferSupported': transferSupported,
        'lookupSupported': lookupSupported,
        'short_name': short_name,
        'support': support,
        'isTransfer': isTransfer,
        'swift_code': swift_code,
      };
}
