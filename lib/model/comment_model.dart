class comment_model {
  dynamic id;
  dynamic comment;
  dynamic course_id;
  dynamic name_user;

  comment_model({
    required this.id,
    required this.comment,
    required this.course_id,
    required this.name_user,
  });

  factory comment_model.fromJson(Map<String, dynamic> json) {
    return comment_model(
      id: json['id'] as dynamic,
      comment: json['comment'] as dynamic,
      course_id: json['course_id'] as dynamic,
      name_user: json['user']['name'] as dynamic,
    );
  }
}
