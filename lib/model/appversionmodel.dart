class AppVersionModel {
  dynamic version;
  dynamic url;

  AppVersionModel({
    required this.version,
    required this.url,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    return AppVersionModel(
      version: json['version'] as dynamic,
      url: json['url'] as dynamic,
    );
  }
}
