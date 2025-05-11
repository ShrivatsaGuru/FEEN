import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 24),
                _buildContactSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3A7CE0),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 1,
          color: Color(0xFF3A7CE0),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildContactCard(
                icon: Icons.email_outlined,
                title: 'E-mail us',
                content: 'federationofeen2020@gmail.com',
                onTap: () => _launchURL('mailto:federationofeen2020@gmail.com'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildContactCard(
                icon: Icons.phone_outlined,
                title: 'Call us directly',
                content: 'Phone: +977 (01) 4002288',
                onTap: () => _launchURL('tel:+9774002288'),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildContactCard(
          icon: Icons.location_on_outlined,
          title: 'FEEN Office',
          content: 'Apsara Marg, Lazimpat, Kathmandu, Nepal',
          onTap: () => _launchURL('https://maps.google.com/?q=Apsara+Marg,+Lazimpat,+Kathmandu,+Nepal'),
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String content,
    required VoidCallback onTap,
    bool fullWidth = false,
  }) {
    return HoverAnimatedContainer(
      onTap: onTap,
      builder: (context, isHovered) {
        return Container(
          width: fullWidth ? double.infinity : null,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF3A7CE0)),
            borderRadius: BorderRadius.circular(8),
            color: isHovered ? Color(0xFFF0F7FF) : Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Color(0xFF3A7CE0),
                size: 32,
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A7CE0),
                ),
              ),
              SizedBox(height: 8),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomNavigationBar(
            backgroundColor: Colors.white.withOpacity(0.5),
            currentIndex: 2, // You can adjust this based on your navigation logic
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF3A7CE0),
            unselectedItemColor: Colors.grey,
            elevation: 0,
            onTap: (index) {
              if (index == 0) {
                // Navigate back to home
                Navigator.of(context).pop();
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

// Custom widget for hover effect
class HoverAnimatedContainer extends StatefulWidget {
  final Widget Function(BuildContext, bool) builder;
  final VoidCallback onTap;

  const HoverAnimatedContainer({
    Key? key,
    required this.builder,
    required this.onTap,
  }) : super(key: key);

  @override
  _HoverAnimatedContainerState createState() => _HoverAnimatedContainerState();
}

class _HoverAnimatedContainerState extends State<HoverAnimatedContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // For mobile, we need to use InkWell instead of MouseRegion
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
          transform: isHovered
              ? Matrix4.identity().scaled(1.05)
              : Matrix4.identity(),
        child: InkWell(
          onTap: widget.onTap,
          onHover: (value) {
            setState(() {
              isHovered = value;
            });
          },
          child: widget.builder(context, isHovered),
        ),
      ),
    );
  }
}