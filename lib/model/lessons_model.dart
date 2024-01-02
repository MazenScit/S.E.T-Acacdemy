class new_lessons_model {
  dynamic id;
  dynamic code;
  dynamic title;
  dynamic description;
  dynamic video_url;
  dynamic duration;
  dynamic poster_url;
  dynamic free;
  dynamic drive_url;
  dynamic subscribed;

  new_lessons_model({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.video_url,
    required this.duration,
    required this.poster_url,
    required this.free,
    required this.drive_url,
    required this.subscribed,
    
  });

  factory new_lessons_model.fromJson(Map<String, dynamic> json) {
    return new_lessons_model(
      id: json['id'] as dynamic,
      code: json['code'] as dynamic,
      title: json['title'] as dynamic,
      description: json['description'] as dynamic,
      video_url: json['video_url'] as dynamic,
      duration: json['duration'] as dynamic,
      poster_url: json['poster_url'] as dynamic,
      free: json['free'] as dynamic,
      drive_url: json['drive_url'] as dynamic,
      subscribed:json['subscribed'] as dynamic,
    );
  }
}
