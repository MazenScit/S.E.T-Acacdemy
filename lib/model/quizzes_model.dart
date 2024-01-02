import 'package:setacademyapp/model/question_model.dart';

class quizzes_model {
  int id;
  dynamic title;
  dynamic duration;
  List<question_model>? questions;

  quizzes_model({
    required this.id,
    required this.title,
    required this.duration,
    this.questions,
  });

  factory quizzes_model.fromJson(Map<String, dynamic> json) {
    return quizzes_model(
      id: json['id'] as int,
      title: json['title'] as dynamic,
      duration: json['duration'] as dynamic,
      questions: List<question_model>.from(
          json["questions"].map((x) => question_model.fromJson(x))),
    );
  }
}
