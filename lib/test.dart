import 'package:flutter/material.dart';
import 'package:ithera/report.dart';

import 'home.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFC),
      body: Stack(
        children: [
          // Camera Icon in top-left
          Positioned(
            left: 20,
            top: 36,
            child: Icon(
              Icons.camera_alt,
              size: 24,
              color: Colors.black,
            ),
          ),

          // Close Icon in top-right (Exit Test Confirmation)
          Positioned(
            right: 20,
            top: 36,
            child: GestureDetector(
              onTap: () {
                _showExitConfirmationDialog(context);
              },
              child: Icon(
                Icons.close,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),

          // Question Box
          Positioned(
            left: 41,
            top: 120,
            child: Container(
              width: 308,
              height: 178,
              decoration: BoxDecoration(
                color: Color(0xFFD3D7DA),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Question 1:\n---------------------------------------------------------\n                  ---------------------------------------',
                  style: TextStyle(
                    color: Color(0xFF052226),
                    fontSize: 15,
                    fontFamily: 'Inika',
                    fontWeight: FontWeight.w400,
                    height: 1.53,
                    letterSpacing: -0.01,
                  ),
                ),
              ),
            ),
          ),

          // Four Choice Buttons
          Positioned(
            left: 48,
            top: 350,
            child: Column(
              children: List.generate(4, (index) {
                return Container(
                  width: 301,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Color(0xFFD3D7DA),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                );
              }),
            ),
          ),

          // Navigation Buttons
          Positioned(
            left: 120,
            top: 600,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the previous question (Implement logic)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFAEB4B8),
                minimumSize: Size(44, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            right: 120,
            top: 600,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFAEB4B8),
                minimumSize: Size(44, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show Exit Confirmation Dialog
  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit Test"),
          content: Text("Are you sure you want to exit the test?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog and stay in test
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
