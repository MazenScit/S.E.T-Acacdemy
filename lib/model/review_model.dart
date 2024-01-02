class review_model {
  dynamic id;
  dynamic rate;
  dynamic course_id;
  dynamic name_user;
  dynamic message;

  review_model({
    required this.id,
    required this.rate,
    required this.course_id,
    required this.name_user,
    required this.message,
  });

  factory review_model.fromJson(Map<String, dynamic> json) {
    return review_model(
      id: json['id'] as dynamic,
      rate: json['rate'] as dynamic,
      course_id: json['course_id'] as dynamic,
      name_user: json['user']['name'] as dynamic,
      message: json['message'] as dynamic,
    );
  }
}
