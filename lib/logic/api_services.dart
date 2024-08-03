import 'dart:convert';

import 'package:internshala/models/intern_model.dart';
import 'package:http/http.dart' as http;
const String apiUrl = 'https://internshala.com/flutter_hiring/search';

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

Future<List<String>> filterInternships(
    Search searchData, String query) async {
  final internshipsMeta = searchData.internshipsMeta;
  final filtered = searchData.internshipIds.where((internshipId) {
    final internship = internshipsMeta[internshipId.toString()];
    final title = internship?.title?.toLowerCase() ?? '';
    final company = internship?.companyName?.toLowerCase() ?? '';
    final locations = internship?.locationNames?.map((loc) => loc.toLowerCase()).toList() ?? [];
    final stipend = internship?.stipend?.salaryValue1?.toString() ?? '';
    final startDate = internship?.startDate?.toLowerCase() ?? '';

    final searchTerm = query.toLowerCase();

    return title.contains(searchTerm) ||
           company.contains(searchTerm) ||
           locations.any((loc) => loc.contains(searchTerm)) ||
           stipend.contains(searchTerm) ||
           startDate.contains(searchTerm);
  }).map((id) => id.toString()).toList();

  return filtered;
}


