class my_coursee_model {
  final dynamic id;
  final dynamic code;
  final dynamic subcategory_id;
  final dynamic title;
  final dynamic title_array;
  final dynamic description;
  final dynamic description_array;
  final dynamic image;
  final dynamic price;
  final dynamic type;
  final dynamic request;
  final dynamic watching_ratio;
  final dynamic hours;
  final dynamic chapters_count;

  my_coursee_model({
    required this.id,
    required this.code,
    required this.subcategory_id,
    required this.title,
    required this.title_array,
    required this.description,
    required this.description_array,
    required this.image,
    required this.price,
    required this.type,
    required this.request,
    required this.watching_ratio,
    required this.hours,
    required this.chapters_count,
  });

  factory my_coursee_model.fromJson(Map<String, dynamic> json) {
    return my_coursee_model(
      id: json['id'] as dynamic,
      code: json['code'] as dynamic,
      subcategory_id: json['subcategory_id'] as dynamic,
      title: json['title'] as dynamic,
      title_array: json['title_array'] as dynamic,
      description: json['description'] as dynamic,
      description_array: json['description_array'] as dynamic,
      image: json['image'] as dynamic,
      price: json['price'] as dynamic,
      type: json['type'] as dynamic,
      request: json['request'] as dynamic,
      watching_ratio: json['watching_ratio'] as dynamic,
      hours: json['hours'] as dynamic,
      chapters_count: json['chapters_count'] as dynamic,
    );
  }
}
