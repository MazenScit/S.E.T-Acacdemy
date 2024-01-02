class user_model {
  final dynamic id;
  final dynamic first_name;
  final dynamic middle_name;
  final dynamic last_name;
  final dynamic phone;
  final dynamic email;
  final dynamic address;
  final dynamic image;

  user_model({
    required this.id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.phone,
    required this.email,
    required this.address,
    required this.image,
  });

  factory user_model.fromJson(Map<String, dynamic> json) {
    return user_model(
      id: json['id'] as dynamic,
      first_name: json['first_name'] as dynamic,
      middle_name: json['middle_name'] as dynamic,
      last_name: json['last_name'] as dynamic,
      phone: json['phone'] as dynamic,
      email: json['email'] as dynamic,
      address: json['address'] as dynamic,
      image: json['image'] as dynamic,
    );
  }
}
