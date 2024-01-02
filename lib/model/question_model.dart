class question_model {
  dynamic question;
  dynamic a;
  dynamic b;
  dynamic c;
  dynamic d;
  dynamic answer;

  question_model({
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.answer,
  });

  factory question_model.fromJson(Map<String, dynamic> json) {
    return question_model(
      question: json['question'] as dynamic,
      a: json['a'] as dynamic,
      b: json['b'] as dynamic,
      c: json['c'] as dynamic,
      d: json['d'] as dynamic,
      answer: json['answer'] as dynamic,
    );
  }
}
