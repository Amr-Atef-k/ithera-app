import 'package:flutter/material.dart';
import 'home.dart'; // Import the HomeScreen

class ReportScreen extends StatelessWidget {
  final int score; // Add a field to hold the score

  // Constructor to receive the score
  ReportScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFC),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                // Main Report Container (lifted up)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 155, // Center horizontally
                  top: 70, // Lift up by 100 pixels
                  child: Container(
                    width: 310, // Increased width
                    height: 650, // Increased height
                    decoration: BoxDecoration(
                      color: Color(0xFFD3D7DA),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Full report title
                          Text(
                            'Full report',
                            style: TextStyle(
                              color: Color(0xFF052226),
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 40), // Spacer between title and score
                          // Display the score
                          Text(
                            'Your Score: $score',
                            style: TextStyle(
                              color: Color(0xFF052226),
                              fontSize: 22,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Download Button (lifted up, separate from the Full report container)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 150, // Center horizontally
                  top: 770, // Lift up by 770 pixels (positioned below the Full report container)
                  child: Container(
                    width: 123,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Color(0xFFD3D7DA),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Download',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),

                // OK Button (lifted up, separate from the Full report container, navigates to HomeScreen)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 + 30, // Center horizontally
                  top: 770, // Lift up by 770 pixels (positioned below the Full report container)
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Container(
                      width: 123,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Color(0xFFD3D7DA),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
