class subcategories_model {
  final String id;
  final String code;
  final String category_id;
  final dynamic name;
  final dynamic name_array;
  final dynamic image;

  subcategories_model({
    required this.id,
    required this.code,
    required this.category_id,
    required this.name,
    required this.name_array,
    required this.image,
  });

  factory subcategories_model.fromJson(Map<String, dynamic> json) {
    return subcategories_model(
      id: json['id'] as String,
      code: json['code'] as String,
      category_id: json['category_id'] as String,
      name: json['name'] as dynamic,
      name_array: json['name_array'] as dynamic,
      image: json['image'] as dynamic,
    );
  }
}
