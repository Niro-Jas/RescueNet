import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Consistent light background
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          _buildNotificationCard(
            title: "Issue Resolved",
            description: "Your reported pothole on MG Road has been fixed",
            time: "2 hours ago",
            icon: Icons.circle,
            iconColor: Colors.green,
            isNew: true, // Green dot indicator
          ),
          _buildNotificationCard(
            title: "Status Update",
            description: "Issue #1235 is now in progress",
            time: "1 day ago",
            icon: Icons.wb_sunny_outlined,
            iconColor: Colors.blue.shade400,
          ),
          _buildNotificationCard(
            title: "Points Earned",
            description: "You earned 50 civic points for feedback",
            time: "2 days ago",
            icon: Icons.stars_rounded,
            iconColor: Colors.amber,
          ),
          _buildNotificationCard(
            title: "Report Submitted",
            description: "Your garbage issue report has been received",
            time: "3 days ago",
            icon: Icons.description_outlined,
            iconColor: Colors.grey,
          ),
          _buildNotificationCard(
            title: "Badge Unlocked",
            description: "Congratulations! You earned the 'Civic Hero' badge",
            time: "3 days ago",
            icon: Icons.emoji_events_outlined,
            iconColor: Colors.purple.shade400,
          ),
          const SizedBox(height: 40), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required String time,
    required IconData icon,
    required Color iconColor,
    bool isNew = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    if (isNew)
                      const Icon(Icons.circle, color: Colors.green, size: 8),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}