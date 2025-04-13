class CityV2Model {
  bool success;
  List<CityV2> data;
  String message;

  CityV2Model({required this.success, required this.data, required this.message});

  factory CityV2Model.fromJson(Map<String, dynamic> json) {
    return CityV2Model(
      success: json['success'],
      data: List<CityV2>.from(json['data'].map((city) => CityV2.fromJson(city))),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((city) => city.toJson()).toList(),
      'message': message,
    };
  }
}

class CityV2 {
  int id;
  String name;

  CityV2({required this.id, required this.name});

  factory CityV2.fromJson(Map<String, dynamic> json) {
    return CityV2(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}