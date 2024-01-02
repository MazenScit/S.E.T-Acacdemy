class techers_model {
  dynamic id;
  dynamic first_name;
  dynamic middle_name;
  dynamic last_name;
  dynamic email;
  dynamic image;

  techers_model({
    required this.id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.email,
    required this.image,
  });

  factory techers_model.fromJson(Map<String, dynamic> json) {
    return techers_model(
      id: json['id'] as dynamic,
      first_name: json['first_name'] as dynamic,
      middle_name: json['middle_name'] as dynamic,
      last_name: json['last_name'] as dynamic,
      email: json['email'] as dynamic,
      image: json['image'] as dynamic,
    );
  }
}
