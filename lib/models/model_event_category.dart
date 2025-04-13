class EventCategoryModel {
  final int id;
  final String name;

  EventCategoryModel({required this.id, required this.name});

  factory EventCategoryModel.fromJson(Map<String, dynamic> json) {
    return EventCategoryModel(
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

class EventCategoryResponse {
  final bool success;
  final List<EventCategoryModel> data;
  final String message;

  EventCategoryResponse({required this.success, required this.data, required this.message});

  factory EventCategoryResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<EventCategoryModel> dataList = list.map((i) => EventCategoryModel.fromJson(i)).toList();

    return EventCategoryResponse(
      success: json['success'],
      data: dataList,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}