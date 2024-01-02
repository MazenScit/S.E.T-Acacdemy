class Muniversities {
  final dynamic id;
  final dynamic code;
  final dynamic name;
  final dynamic name_array;

  Muniversities({
    required this.id,
    required this.code,
    required this.name,
    required this.name_array,
  });

  factory Muniversities.fromJson(Map<String, dynamic> json) {
    return Muniversities(
      id: json['id'] as dynamic,
      code: json['code'] as dynamic,
      name: json['name'] as dynamic,
      name_array: json['name_array'] as dynamic,
    );
  }
}
