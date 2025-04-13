import 'package:http/http.dart' as http;
import 'dart:convert';

class TopicRepository {
  final String baseUrl = "http://localhost:8000/api/topics";

  Future<Map<String, dynamic>> fetch(/* {String? startCity, String? endCity, String? date} */) async {
    try {
      Uri url = Uri.parse(baseUrl);

      // Adding parameters if they exist
/*       if (startCity != null || endCity != null || date != null) {
        final queryParams = <String, String>{};
        if (startCity != null) queryParams['start_city'] = startCity;
        if (endCity != null) queryParams['end_city'] = endCity;
        if (date != null) {
          // Format the date
          final formattedDate = DateTime.parse(date).toIso8601String();
          queryParams['date'] = formattedDate;
        }
        url = Uri.parse("$baseUrl?${Uri(queryParameters: queryParams).query}");
      }
 */
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      throw Exception("Error fetching: ${e.toString()}");
    }
  }
}
