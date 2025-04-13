import 'package:listar_flutter_pro/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventRepository {
  final String baseUrl = "http://localhost:8000/api/events";

  Future<EventModel> fetchEvents({dynamic? city, dynamic? category}) async {
    try {
      Uri url = Uri.parse(baseUrl);

      // Dodavanje parametara ako postoje
      if (city != null || category != null) {
        final queryParams = <String, String>{};
        if (city != null) queryParams['city'] = city.toString();
        if (category != null) queryParams['category'] = category.toString();
        url = Uri.parse("$baseUrl?${Uri(queryParameters: queryParams).query}");
      }

      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return EventModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load events");
      }
    } catch (e) {
      throw Exception("Error fetching events: $e");
    }
  }

  Future<EventCategoryResponse> fetchEventCategory() async {
    try {
      Uri url = Uri.parse("$baseUrl/categories");

      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return EventCategoryResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load event categories");
      }
    } catch (e) {
      throw Exception("Error fetching event categories: $e");
    }
  }
}