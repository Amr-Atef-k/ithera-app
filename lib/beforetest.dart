import 'package:flutter/material.dart';
import 'package:ithera/test.dart';


class BeforeTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("before test"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Icon or Image
              Icon(
                Icons.assignment, // Replace with your desired icon or image
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              // Bullet points
              _buildBulletPoint("this test will use your camera and microphone"),
              _buildBulletPoint("this test will take about 30:45 minutes"),
              _buildBulletPoint("the test will be a series of questions about your feelings and different situations"),
              _buildBulletPoint("remember this assessment is a preliminary tool and should not be used as a definitive diagnosis of any psychological condition."),

              SizedBox(height: 30),
              // Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Test()),
                  );
                },
                child: Text("give permission, start the test"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Color(0xFF90EE90), // Light green color
                  foregroundColor: Colors.white, // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("•", style: TextStyle(fontSize: 16)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}