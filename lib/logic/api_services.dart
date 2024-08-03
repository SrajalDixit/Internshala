import 'dart:convert';

import 'package:internshala/models/intern_model.dart';
import 'package:http/http.dart' as http;

Future<Search> fetchInternships() async {
  final url = 'https://internshala.com/flutter_hiring/search';

  try {
    final response = await http.get(Uri.parse(url));

    // Check if the response is successful
    if (response.statusCode == 200) {
      // Check if the response body is not null
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Parse JSON into Search model
        return Search.fromJson(jsonResponse);
      } else {
        throw Exception('Response body is empty');
      }
    } else {
      throw Exception('Failed to load internships: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching internships: $e');
  }
}
