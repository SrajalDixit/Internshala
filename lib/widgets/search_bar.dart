import 'package:flutter/material.dart';
import 'package:internshala/util/constants.dart'; // Ensure this imports the correct constant

class searchBar extends StatelessWidget {
  final Function(String) onSearchChanged;
  final VoidCallback onFilterPressed;

  const searchBar({
    Key? key,
    required this.onSearchChanged,
    required this.onFilterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          TextField(
            cursorColor: mainColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: mainColor),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black54,
                size: 28.0,
              ),
              hintText: 'Search here...',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: Container(
                width: 60,
                height: 20, // Adjusted height to fit the icon
                margin: const EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: mainColor, width: 1.5),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: mainColor,
                      size: 28.0,
                    ),
                    onPressed: onFilterPressed,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
              ),
            ),
            onChanged: onSearchChanged,
          ),
        ],
      ),
    );
  }
}
