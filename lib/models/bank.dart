class Bank {
  final String name;
  final String code;
  final String logo;

  Bank({
    required this.name,
    required this.code,
    required this.logo,
  });

  // json => dart
  Bank.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        code = json['code'],
        logo = json['logo'];

  // dart => json
  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
        'logo': logo,
      };
}
