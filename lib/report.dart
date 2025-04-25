import 'package:flutter/material.dart';
import 'home.dart'; // Import the HomeScreen

// ReportScreen displays the user's score and interpretation based on score ranges
class ReportScreen extends StatelessWidget {
  final int score; // Add a field to hold the score

  // Constructor to receive the score
  ReportScreen({required this.score});

  // Determines the interpretation based on the score
  Map<String, dynamic> _getInterpretation() {
    if (score >= 10 && score <= 20) {
      return {
        'status': 'Stable Mood',
        'emoji': '🟢',
        'interpretation':
        'You seem to be emotionally well. No clear signs of mental health issues are present. Keep up your positive habits!'
      };
    } else if (score >= 21 && score <= 30) {
      return {
        'status': 'Mild Symptoms',
        'emoji': '🟡',
        'interpretation':
        'You may be experiencing some mild signs of stress, anxiety, or sadness. Consider monitoring your mood and practicing self-care regularly.'
      };
    } else if (score >= 31 && score <= 40) {
      return {
        'status': 'Moderate to High Risk',
        'emoji': '🟠',
        'interpretation':
        'There are clear symptoms of anxiety or depression. It is highly recommended to speak to a mental health professional for proper support.'
      };
    } else {
      return {
        'status': 'Critical Mood Concern',
        'emoji': '🔴',
        'interpretation':
        'You may be facing severe psychological distress. Please seek immediate help from a qualified mental health specialist. You are not alone.'
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final interpretation = _getInterpretation();

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
                            'Your Score: $score / 40',
                            style: TextStyle(
                              color: Color(0xFF052226),
                              fontSize: 22,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20), // Spacer between score and status
                          // Display the status with emoji
                          Text(
                            '${interpretation['emoji']} ${interpretation['status']}',
                            style: TextStyle(
                              color: Color(0xFF052226),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20), // Spacer between status and interpretation
                          // Display the interpretation text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              interpretation['interpretation'],
                              style: TextStyle(
                                color: Color(0xFF052226),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
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
                  top: 770, // Positioned below the Full report container
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

                // OK Button (lifted up, navigates to HomeScreen)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 + 30, // Center horizontally
                  top: 770, // Positioned below the Full report container
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (route) => false,
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