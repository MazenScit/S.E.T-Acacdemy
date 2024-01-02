class files_model {
  dynamic id;
  dynamic chapter_id;
  dynamic file;
  dynamic file_url;
  dynamic file_name;
  dynamic free;

  files_model({
    required this.id,
    required this.chapter_id,
    required this.file,
    required this.file_url,
    required this.file_name,
    required this.free,
  });

  factory files_model.fromJson(Map<String, dynamic> json) {
    return files_model(
      id: json['id'] as dynamic,
      chapter_id: json['chapter_id'] as dynamic,
      file: json['file'] as dynamic,
      file_url: json['file_url'] as dynamic,
      file_name: json['file_name'] as dynamic,
      free: json['free'] as dynamic,
    );
  }
}
