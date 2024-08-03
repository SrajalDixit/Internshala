import 'package:flutter/material.dart';
import 'package:internshala/util/constants.dart'; // Make sure this imports the correct constant

class searchBar extends StatelessWidget {
  final Function(String) onSearchChanged; // Add this line

  const searchBar({Key? key, required this.onSearchChanged}) : super(key: key); // Update constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        cursorColor: mainColor, // Neon blue cursor color
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey), // Grey border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: mainColor), // Neon blue border color
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black54,
            size: 28.0, // Size of the search icon
          ),
          hintText: 'Search here...',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ), // Grey color for hint text
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0), // Adjust height
        ),
        onChanged: onSearchChanged, // Update this line
      ),
    );
  }
}
