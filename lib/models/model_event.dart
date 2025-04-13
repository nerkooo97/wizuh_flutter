class EventModel {
  bool? success;
  List<Data>? data;
  String? message;

  EventModel({this.success, this.data, this.message});

  EventModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  CategoryEvents? category;
  City? city;
  int? featured;
  String? image;
  String? date;
  String? time;
  String? link_type;
  String? link;

  Data(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.city,
      this.featured,
      this.image,
      this.date,
      this.time,
      this.link_type,
      this.link,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'] != null ? CategoryEvents.fromJson(json['category']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    featured = json['featured'];
    image = json['image'];
    date = json['date'];
    time = json['time'];
    link_type = json['link_type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['featured'] = featured;
    data['image'] = image;
    data['date'] = date;
    data['time'] = time;
    data['link_type'] = link_type;
    data['link'] = link;
    return data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class CategoryEvents{
  int? id;
  String? name;

  CategoryEvents({this.id, this.name});

  CategoryEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
