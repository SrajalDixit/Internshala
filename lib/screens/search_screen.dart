import 'package:flutter/material.dart';
import 'package:internshala/logic/api_services.dart'; // Ensure this imports the correct function
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

  @override
  void initState() {
    super.initState();
    _loadInternships();
  }

  Future<void> _loadInternships() async {
    try {
      final data = await fetchInternships();
      print('Fetched Internships: $data'); // Print fetched data for debugging
      setState(() {
        searchData = data;
        filteredInternshipIds = data.internshipIds.map((id) => id.toString()).toList(); // Initialize with all internships
      });
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

  @override
  Widget build(BuildContext context) {
    // Get internships from searchData
    final internshipsMeta = searchData?.internshipsMeta ?? {};

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
        title: Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
         searchBar(onSearchChanged: _onSearch,),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredInternshipIds.length,
              itemBuilder: (context, index) {
                final internshipId = filteredInternshipIds[index];
                final internship = internshipsMeta[internshipId.toString()];

                // Ensure internship is not null
                if (internship == null) {
                  return SizedBox.shrink(); // Empty widget if internship data is not found
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
