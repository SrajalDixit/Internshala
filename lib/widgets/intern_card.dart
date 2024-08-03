import 'package:flutter/material.dart';
import 'package:internshala/util/constants.dart';

class InternCard extends StatelessWidget {
  const InternCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Set card color to white
      elevation: 0.0, // Remove shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
            color: Colors.grey, width: 1.0), // Grey border color and width
      ),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter Development',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Company Name',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(
                  Icons.home_outlined,
                  color: Colors.black54,
                ),
                SizedBox(width: 8.0),
                Text('Work from Home'),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.play_circle_outlined,
                  color: Colors.black54,
                ),
                SizedBox(width: 8.0),
                Text('Starts Immediately'),
                SizedBox(width: 15.0),
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.black54,
                ),
                SizedBox(width: 8.0),
                Text('1 Month'),
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
                Text('₹5,000/month'),
              ],
            ),
            SizedBox(height: 16.0), // Space before the button
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Feature yet to be implemented'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  'View Details',
                  style: TextStyle(
                    color: mainColor, // Blue color for the text
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
