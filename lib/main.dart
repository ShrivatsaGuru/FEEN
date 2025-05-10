import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Oswald',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildAppBar(), // App bar at the top
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDiscoverSection(),
                        _buildAdSection(),
                        _buildGallerySection(),
                        _buildNoticeSection(),
                        // Add extra padding at the bottom
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(10), // Set fixed height
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Blue
              Colors.white,
              Color(0xFF0348A8), // White
            ],
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('photos/profile.png'),
                  ),
                  SizedBox(width: 8), // Space between avatar and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Admin',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18, // Increased font size
                        ),
                      ),
                      Text(
                        'admin@domain.com',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14, // Increased font size
                          fontWeight: FontWeight.bold, // Bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0623C3),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 29,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover',
            style: TextStyle(
              fontSize: 29, // Increased font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF0623C3),
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 1,
            color: Color(0xFF3A7CE0),

          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  'Announcement',
                  '8 Notifications',
                  Icons.campaign_outlined,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(
                  'Updates',
                  '2 Notifications',
                  Icons.update_outlined,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  'Upcoming\nEvents',
                  '2 Notifications',
                  Icons.emoji_events_outlined,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(
                  'Complaints',
                  '0 Notifications',
                  Icons.description_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF0348A8)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF3A7CE0),
                radius: 20,
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3A7CE0),
                      fontSize: 13.5, // Increased font size
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13, // Increased font size
                      fontWeight: FontWeight.bold, // Bold
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF3A7CE0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                'Ad',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14, // Increased font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Image.network(
                'https://picsum.photos/600/300?tech',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGallerySection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gallery',
            style: TextStyle(
              fontSize: 29, // Increased font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF3A7CE0),
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 1,
            color: Color(0xFF3A7CE0),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://picsum.photos/300/200?conference=1',
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://picsum.photos/300/200?event=1',
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notice',
            style: TextStyle(
              fontSize: 29, // Increased font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF3A7CE0),
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 1,
            color: Color(0xFF3A7CE0),
          ),
          SizedBox(height: 16),
          _buildNoticeCard(),
          SizedBox(height: 16),
          _buildNoticeCard(),
        ],
      ),
    );
  }

  Widget _buildNoticeCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3A7CE0)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workshop on Smart Grid Technology',
            style: TextStyle(
              fontSize: 18, // Increased font size
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'The Electrical Engineering Association is organizing a workshop on Smart Grid Technology to enhance students\' understanding of modern power systems and automation.',
            style: TextStyle(
              fontSize: 16, // Increased font size
              color: Colors.black54,
              fontWeight: FontWeight.bold, // Bold
            ),
          ),
          SizedBox(height: 12),
          Container(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF3A7CE0),
                side: BorderSide(color: Color(0xFF3A7CE0)),
                padding: EdgeInsets.symmetric(horizontal: 12),
                minimumSize: Size(150, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Add to Calendar',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Bold
                  fontSize: 14, // Increased font size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1), // Semi-transparent white
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Rounded edges
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 100,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // Blur effect
          child: BottomNavigationBar(
            backgroundColor: Colors.white.withOpacity(0.1), // Match translucent effect
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF3A7CE0),
            unselectedItemColor: Colors.black,
            elevation: 0, // Remove default elevation
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.campaign_outlined),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.headset_mic_outlined),
                label: 'Support',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}