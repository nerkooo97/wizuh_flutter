import 'package:listar_flutter_pro/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityV2Repository {
  final String baseUrl = "http://127.0.0.1:8000/api/events/cities";

  Future<CityV2Model> fetchCities() async {
    try {
      Uri url = Uri.parse(baseUrl);

      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return CityV2Model.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load events");
      }
    } catch (e) {
      throw Exception("Error fetching events: $e");
    }
  }
}