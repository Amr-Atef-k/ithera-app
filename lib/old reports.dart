import 'package:flutter/material.dart';

class OLDReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Old Reports"),
        backgroundColor: Color(0xFF4CADE0),
      ),
      body: Center(
        child: Text(
          "This is the Old Reports screen",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}