import 'package:flutter/material.dart';
import 'package:internshala/util/constants.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? _selectedDuration;
  List<String> _selectedTitles = [];
  List<String> _selectedCities = [];

  void _applyFilters() {
    Navigator.pop(context, {
      'titles': _selectedTitles,
      'cities': _selectedCities,
      'duration': _selectedDuration,
    });
  }

  // List of available roles
  final List<String> _roles = [
    'Data Science Intern',
    'Administration Intern',
    'Business Analytics Intern',
    'Brand Management Intern',
  ];

  // List of available cities
  final List<String> _cities = [
    'Agra',
    'Ahmedabad',
    'Aurangabad',
    'Bangalore',
    'Bhopal',
    'Chandigarh',
    'Chennai',
    'Coimbatore',
    'Delhi',
    'Guwahati',
    'Gurgaon',
    'Hyderabad',
    'Indore',
    'Jaipur',
    'Kanpur',
    'Kolkata',
    'Lucknow',
    'Mangalore',
    'Mumbai',
    'Nagpur',
    'Noida',
    'Patna',
    'Pune',
    'Ranchi',
    'Surat',
    'Vadodara',
    'Visakhapatnam'
  ];

  void _cancelFilters() {
    setState(() {
      // Reset selections
      _selectedTitles.clear();
      _selectedCities.clear();
      _selectedDuration = null;
    });
    Navigator.pop(context); // Navigate back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Filters',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PROFILE',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.0),
            MultiSelectDialogField(
              searchable: true,
              items: _roles
                  .map((role) => MultiSelectItem<String>(role, role))
                  .toList(),
              title: Text("Select Roles"),
              selectedColor: mainColor,
              decoration: BoxDecoration(
                border: Border.all(
                  color: mainColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              isDismissible: true,
              buttonText: Text(
                "Select profile",
                style: TextStyle(
                  color: mainColor,
                  fontSize: 16,
                ),
              ),
              chipDisplay: MultiSelectChipDisplay(
                onTap: (item) {
                  setState(() {
                    _selectedTitles.remove(item);
                  });
                },
                // Customize chip display
                chipColor: Colors.grey.withOpacity(0.2),
                textStyle: TextStyle(color: mainColor),
              ),
              onConfirm: (results) {
                setState(() {
                  _selectedTitles = results.cast<String>();
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'CITY',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.0),
            MultiSelectDialogField(
              searchable: true,
              items: _cities
                  .map((city) => MultiSelectItem<String>(city, city))
                  .toList(),
              title: Text("Select Cities"),
              selectedColor: mainColor,
              decoration: BoxDecoration(
                border: Border.all(
                  color: mainColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              isDismissible: true,
              buttonText: Text(
                "Select city",
                style: TextStyle(
                  color: mainColor,
                  fontSize: 16,
                ),
              ),
              chipDisplay: MultiSelectChipDisplay(
                onTap: (item) {
                  setState(() {
                    _selectedCities.remove(item);
                  });
                },
                // Customize chip display
                chipColor: Colors.grey.withOpacity(0.2),
                textStyle: TextStyle(color: mainColor),
              ),
              onConfirm: (results) {
                setState(() {
                  _selectedCities = results.cast<String>();
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'MAXIMUM DURATION (IN MONTHS)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              value: _selectedDuration,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDuration = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Choose Duration',
                labelStyle: TextStyle(color: mainColor, fontSize: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
              items: <String>['1', '2', '3', '4', '6', '12', '24', '36']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Add Spacer to push buttons up
            Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _cancelFilters,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Button color
                    onPrimary: Colors.white, // Text color
                  ),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    primary: mainColor, // Button color
                    onPrimary: Colors.white, // Text color
                  ),
                  child: Text('Apply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
