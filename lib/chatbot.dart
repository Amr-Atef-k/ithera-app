import 'package:flutter/material.dart';

class Chatbot extends StatelessWidget {
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

          // Center the circle and text vertically (lifted up a little)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                // Lift up the circle and text by reducing the vertical space
                Transform.translate(
                  offset: Offset(0, -120), // Move up by 50 pixels
                  child: Column(
                    children: [
                      // Circle with "logo" text
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.pink[300],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "logo",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      // Text below the circle
                      Padding(
                        padding: EdgeInsets.only(top: 20), // Add spacing between circle and text
                        child: Text(
                          "Chat with the AI about anything related to physical conditions.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // "Type here" input field at the bottom
          Positioned(
            left: 20,
            right: 20,
            bottom: 20, // Position at the bottom
            child: TextField(
              decoration: InputDecoration(
                hintText: 'type here',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 15,
                  fontFamily: 'Imprima',
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Color(0xFFD3D7DA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}