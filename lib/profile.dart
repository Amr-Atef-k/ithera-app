import 'package:flutter/material.dart';
import 'old reports.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFC),
      body: Stack(
        children: [
          // Back arrow at the top left
          Positioned(
            left: 10,
            top: 20, // Adjust top position as needed
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // Navigate back to HomeScreen
              },
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFA2D2FB),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 50,
                    color: Colors.black,
                  ),
                ),

                // "Name here" text below the profile picture
                Padding(
                  padding: EdgeInsets.only(top: 10), // Add spacing between icon and text
                  child: Text(
                    "Name here",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 40), // Add spacing between text and buttons

                // Edit Button
                _buildButton("Edit", () {}),
                SizedBox(height: 15),

                // Old Reports Button (Navigates to ReportScreen)
                _buildButton("Old Reports", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OLDReportScreen()),
                  );
                }),
                SizedBox(height: 15),

                // Change User Button
                _buildButton("Change the user", () {}),
                SizedBox(height: 15),

                // Report a Problem Button
                _buildButton("Report a problem", () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Button Function
  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 240,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFD3D7DA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF052226),
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}