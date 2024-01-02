class Mgovernorates {
  final dynamic id;
  final dynamic code;
  final dynamic name;
  final dynamic name_array;

  Mgovernorates({
    required this.id,
    required this.code,
    required this.name,
    required this.name_array,
  });

  factory Mgovernorates.fromJson(Map<String, dynamic> json) {
    return Mgovernorates(
      id: json['id'] as dynamic,
      code: json['code'] as dynamic,
      name: json['name'] as dynamic,
      name_array: json['name_array'] as dynamic,
    );
  }
}
