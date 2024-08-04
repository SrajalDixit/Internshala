import 'package:flutter/material.dart';
import 'package:internshala/models/intern_model.dart'; // Ensure this imports Stipend

class InternCard extends StatelessWidget {
  final String title;
  final String company;
  final List<String> locations;
  final String duration;
  final Stipend? stipend; // Update to Stipend
  final String startDate;

  const InternCard({
    Key? key,
    required this.title,
    required this.company,
    required this.locations,
    required this.duration,
    this.stipend, // Update to Stipend
    required this.startDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationText =
        locations.isNotEmpty ? locations.join(' , ') : 'Remote';
    // Handle stipend display
    final stipendText = stipend != null
        ? '${stipend?.currency ?? ''} ${stipend?.salaryValue1?.toString() ?? 'No Stipend'}'
        : 'No Stipend';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        border: Border.all(
          color: Colors.grey[400]!, // Grey border color
          width: 1.0, // Border width
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              company,
              style: TextStyle(
                color: Colors.grey[700]!,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.black54,
                ),
                SizedBox(width: 8.0),
                Text(locationText),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.play_circle_outline,
                  color: Colors.black54,
                ),
                SizedBox(width: 8.0),
                Text(startDate),
                SizedBox(width: 50.0),
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.black54,
                ),
                SizedBox(width: 8.0),
                Text('$duration'),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.money,
                  color: Colors.black54,
                ),
                SizedBox(width: 8.0),
                Text(stipendText), // Display stipend
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'View details functionality yet to be implemented'),
                      ),
                    );
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
