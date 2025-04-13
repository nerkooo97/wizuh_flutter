class TopicResponse {
  TopicResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool? success;
  final List<TopicModel> data;
  final String? message;

  factory TopicResponse.fromJson(Map<String, dynamic> json) {
    return TopicResponse(
      success: json["success"],
      data: json["data"] == null ? [] : List<TopicModel>.from(json["data"]!.map((x) => TopicModel.fromJson(x))),
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.map((x) => x.toJson()).toList(),
    "message": message,
  };

  @override
  String toString() {
    return "$success, $data, $message, ";
  }
}

class TopicModel {
  TopicModel({
    required this.id,
    required this.title,
    required this.categories,
    required this.excerpt,
    required this.date,
    required this.link,
    required this.featuredMediaUrl,
  });

  final int? id;
  final String? title;
  final List<int> categories;
  final String? excerpt;
  final DateTime? date;
  final String? link;
  final String? featuredMediaUrl;

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      title: json['title'],
      categories: json['categories'] == null ? [] : List<int>.from(json['categories']),
      excerpt: json['excerpt'],
      date: json['date'] == null ? null : DateTime.parse(json['date']),
      link: json['link'],
      featuredMediaUrl: json['featured_media_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'categories': categories,
    'excerpt': excerpt,
    'date': date?.toIso8601String(),
    'link': link,
    'featured_media_url': featuredMediaUrl,
  };

  @override
  String toString() {
    return "$id, $title, $categories, $excerpt, $date, $link, $featuredMediaUrl, ";
  }
}