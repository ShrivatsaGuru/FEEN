import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Complaint.dart';
import 'dart:ui';
import 'contact_us_page.dart'; // Import the Contact Us page
import 'EventsPage.dart';
import 'Updates.dart';
import 'Announcements.dart';
import 'Complaint.dart';
import 'login_screen.dart';
import 'register_screen.dart';
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
      ),
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/contact': (context) => ContactUsPage(),
        '/events': (context) => EventsPage(),
        '/updates': (context) => UpdatesScreen(),
        '/announcement': (context) => AnnouncementsScreen(),
        '/complaint': (context) => ComplaintPage(),
      },
      initialRoute: '/login',
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
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDiscoverSection(context),
                        _buildAdSection(),
                        _buildGallerySection(),
                        _buildNoticeSection(),

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
              child: _buildBottomNavigationBar(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Blue
              Colors.white,
              Color(0xFF82B3F2),
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
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Admin',
                        style: TextStyle(
                          color: Color(0xFF0B4DA1),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'admin@domain.com',
                        style: TextStyle(
                          color: Color(0xFF0B4DA1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0070FF),
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

  Widget _buildDiscoverSection(BuildContext context)
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B4DA1),
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 1,
            color: Color(0xFF0B4DA1),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/announcement');
                  },
                child: _buildInfoCard(
                  'Announcements',
                  '8 Notifications',
                  Icons.campaign_outlined,
                ),
              ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/updates');
                  },
                  child: _buildInfoCard(
                    'Updates',
                    '2 Notifications',
                    Icons.update_outlined,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/events');
                  },
                  child: _buildInfoCard(
                    'Upcoming Events',
                    '2 Notifications',
                    Icons.emoji_events_outlined,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/complaint');
                  },
                  child: _buildInfoCard(
                    'Complaint',
                    '2 Notifications',
                    Icons.update_outlined,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildInfoCard(String title, String subtitle, IconData iconData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3A7CE0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF3A7CE0),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B4DA1),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
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
                  fontSize: 12,
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B4DA1),
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 1,
            color: Color(0xFF0B4DA1),
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B4DA1),
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 1,
            color: Color(0xFF0B4DA1),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'The Electrical Engineering Association is organizing a workshop on Smart Grid Technology to enhance students\' understanding of modern power systems and automation.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
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
              child: Text('Add to Calendar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
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
            backgroundColor: Colors.white.withOpacity(0.1),
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF3A7CE0),
            unselectedItemColor: Colors.black,
            elevation: 0,
            onTap: (index) {
              switch (index) {
                case 0:
                // Stay on Home
                  break;
                case 1:
                // Navigate to Alerts (not implemented yet)
                  break;
                case 2:
                  Navigator.pushNamed(context, '/contact'); // Example target
                  break;
                case 3:
                // Navigate to Profile (not implemented yet)
                  break;
              }
            },
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