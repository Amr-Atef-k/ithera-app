import 'package:flutter/material.dart';
import 'package:ithera/profile.dart';
import 'beforetest.dart';
import 'chatbot.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "IThera",
          style: TextStyle(
            fontSize: 22,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2182C0),
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.grid_view_rounded, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.purple,
            height: 2.0,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink[300],
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.article_sharp),
              title: Text("Articles and FAQs"),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Locate a near therapist"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Main content (lifted up a little)
          Transform.translate(
            offset: Offset(0, -30), // Lift up by 30 pixels
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Center(
                  child: Container(
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
                ),
                SizedBox(height: 30),

                // Info Box
                Container(
                  width: 250,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "info about the application",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Take The Test Button -> Navigates to BeforeTest
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BeforeTest()),
                    );
                  },
                  child: Text(
                    "TAKE THE TEST",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),

          // Chat with AI Floating Button and Text at Bottom Right (lifted up a little)
          Positioned(
            right: 20,
            bottom: 30, // Adjusted bottom position (lifted up)
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Align text and icon vertically
              children: [
                Text(
                  "Chat with an AI",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10), // Add spacing between text and icon
                FloatingActionButton(
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    // Navigate to Chatbot Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Chatbot()),
                    );
                  },
                  child: Icon(Icons.chat, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}