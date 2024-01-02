class courses_model {
  dynamic id;
  dynamic code;
  dynamic title;
  dynamic title_array;
  dynamic image;
  dynamic course_id;

  courses_model({
    required this.id,
    required this.code,
    required this.title,
    required this.title_array,
    required this.image,
    required this.course_id,
  });

  factory courses_model.fromJson(Map<String, dynamic> json) {
    return courses_model(
      id: json['id'] as dynamic,
      code: json['code'] as dynamic,
      title: json['title'] as dynamic,
      title_array: json['title_array'] as dynamic,
      image: json['image'] as dynamic,
      course_id: json['course_id'] as dynamic,
    );
  }
}
