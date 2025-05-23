class FileModel {
  final String name;
  final String type;
  final String url;
  final String size;

  FileModel({
    required this.name,
    required this.type,
    required this.url,
    required this.size,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    final arrayName = json['name'].split('.');
    // ignore: unused_local_variable
    String size = "";
    if (json['size'] is String) {
      size = json['size'];
    }
    return FileModel(
      name: arrayName[0],
      type: arrayName[1],
      url: json['url'],
      size: json['size'],
    );
  }
}
