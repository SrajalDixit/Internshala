import 'package:flutter/material.dart';
import 'package:internshala/logic/api_services.dart'; // Ensure this imports the correct function
import 'package:internshala/screens/filter_screen.dart';
import 'package:internshala/widgets/intern_card.dart';
import 'package:internshala/widgets/search_bar.dart';
import 'package:internshala/models/intern_model.dart'; // Import the Internship model

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Search? searchData; // Change to Search
  List<String> filteredInternshipIds = [];
  String query = '';
  List<String> _selectedRoles = [];
  List<String> _selectedCities = [];
  String? _selectedDuration;

  @override
  void initState() {
    super.initState();
    _loadInternships();
  }

  Future<void> _loadInternships() async {
    try {
      final data = await fetchInternships();
      setState(() {
        searchData = data;
        filteredInternshipIds = data.internshipIds
            .map((id) => id.toString())
            .toList(); // Initialize with all internships
      });
      _applyFilters(); // Apply filters after loading internships
    } catch (e) {
      print('Error fetching internships: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to load internships. Please check your internet connection and try again.'),
        ),
      );
    }
  }

  void _onSearch(String query) async {
    if (searchData != null) {
      final filtered = await filterInternships(searchData!, query);
      setState(() {
        filteredInternshipIds = filtered;
      });
    }
  }

  void _applyFilters() {
  if (searchData != null && searchData!.internshipsMeta.isNotEmpty) {
    final internshipsMeta = searchData!.internshipsMeta;

    final filtered = searchData!.internshipIds
        .where((id) {
          final internship = internshipsMeta[id.toString()];
          if (internship == null) return false;

          final title = internship.title?.toLowerCase().trim() ?? '';
          final locationNames = internship.locationNames
              ?.map((loc) => loc.toLowerCase().trim())
              .toList() ?? [];
          final duration = internship.duration?.toLowerCase().trim() ?? '';

          // Normalize selected roles
          final normalizedSelectedRoles = _selectedRoles
              .map((role) => role.toLowerCase().trim())
              .toList();

          // Normalize selected cities
          final normalizedSelectedCities = _selectedCities
              .map((city) => city.toLowerCase().trim())
              .toList();

          // Normalize selected duration
          final normalizedSelectedDuration = _selectedDuration?.toLowerCase().trim();

          // Debugging prints
          print('Internship ID: $id');
          print('Title: $title');
          print('Location Names: $locationNames');
          print('Duration: $duration');
          print('Selected Roles: $normalizedSelectedRoles');
          print('Selected Cities: $normalizedSelectedCities');
          print('Selected Duration: $normalizedSelectedDuration');

          // Apply filters
          final matchesRole = _selectedRoles.isEmpty ||
              normalizedSelectedRoles.isEmpty ||
              normalizedSelectedRoles.any((role) =>
                  title.contains(role)); // Check if title contains any role

          final matchesCity = _selectedCities.isEmpty ||
              locationNames.any((city) => normalizedSelectedCities.contains(city)); // Check if any location matches selected cities

          final matchesDuration = normalizedSelectedDuration == null ||
              duration == normalizedSelectedDuration; // Check if duration matches selected duration

          print('Matches Role: $matchesRole');
          print('Matches City: $matchesCity');
          print('Matches Duration: $matchesDuration');

          return matchesRole && matchesCity && matchesDuration;
        })
        .map((id) => id.toString())
        .toList();

    setState(() {
      filteredInternshipIds = filtered;
    });
  } else {
    print('No internships data available');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          searchBar(
            onSearchChanged: _onSearch,
            onFilterPressed: () async {
              final filters = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FilterScreen()),
              );

              if (filters != null) {
                setState(() {
                  _selectedRoles = List<String>.from(filters['roles'] ?? []);
                  _selectedCities = List<String>.from(filters['cities'] ?? []);
                  _selectedDuration = filters['duration'] ?? null;
                });

                _applyFilters(); // Apply filters when they are updated
              }
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredInternshipIds.length,
              itemBuilder: (context, index) {
                final internshipId = filteredInternshipIds[index];
                final internship =
                    searchData?.internshipsMeta[internshipId.toString()];

                // Ensure internship is not null
                if (internship == null) {
                  return SizedBox
                      .shrink(); // Empty widget if internship data is not found
                }

                return InternCard(
                  title: internship.title ?? 'No Title',
                  company: internship.companyName ?? 'No Company',
                  locations: internship.locationNames ?? [],
                  duration: internship.duration ?? 'No Duration',
                  stipend: internship.stipend,
                  startDate: internship.startDate ?? 'Start Date Not Available',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
