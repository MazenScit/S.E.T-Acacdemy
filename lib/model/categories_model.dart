class categories_model {
  dynamic id;
  dynamic code;
  dynamic name;
  dynamic name_array;
  dynamic image;

  categories_model({
    required this.id,
    required this.code,
    required this.name,
    required this.name_array,
    required this.image,
  });

  factory categories_model.fromJson(Map<String, dynamic> json) {
    return categories_model(
      id: json['id'] as dynamic,
      code: json['code'] as dynamic,
      name: json['name'] as dynamic,
      name_array: json['name_array'] as dynamic,
      image: json['image'] as dynamic,
    );
  }
}
