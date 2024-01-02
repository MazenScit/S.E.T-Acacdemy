class Mspecializations {
  final String id;
  final String code;
  final String name;
  final dynamic name_array;

  Mspecializations({
    required this.id,
    required this.code,
    required this.name,
    required this.name_array,
  });

  factory Mspecializations.fromJson(Map<String, dynamic> json) {
    return Mspecializations(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      name_array: json['name_array'] as dynamic,
    );
  }
}
