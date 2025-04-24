import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Import this
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
              Icon(Icons.assignment, size: 80, color: Colors.grey),
              SizedBox(height: 20),
              _buildBulletPoint("this test will use your camera and microphone"),
              _buildBulletPoint("this test will take about 30:45 minutes"),
              _buildBulletPoint("the test will be a series of questions about your feelings and different situations"),
              _buildBulletPoint("remember this assessment is a preliminary tool..."),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final cameras = await availableCameras(); // ⬅️ Get cameras
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestPage(cameras: cameras), // ⬅️ Pass them
                    ),
                  );
                },
                child: Text("give permission, start the test"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Color(0xFF90EE90),
                  foregroundColor: Colors.white,
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
