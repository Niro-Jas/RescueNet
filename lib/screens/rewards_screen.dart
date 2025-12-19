import 'package:flutter/material.dart';
// Note: Ensure this matches your home screen's filename
import 'home_screen.dart'; 

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Ultra-light grey/blue background
      appBar: AppBar(
        title: const Text("Rewards & Points",
            style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.w800)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: () {
            // This ensures it goes to Home and clears the "dark page" memory
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            // 1. MAIN POINTS CARD
            _buildMainPointsCard(),
            
            const SizedBox(height: 30),
            const Text("Badges & Achievements",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 16),
            
            // 2. BADGE GRID
            _buildBadgeGrid(),
            
            const SizedBox(height: 30),
            const Text("Recent Activity",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 16),

            // 3. RECENT ACTIVITY LIST
            _buildRecentActivityList(),

            const SizedBox(height: 20),

            // 4. HOW TO EARN POINTS GUIDE
            _buildEarnPointsGuide(),

            const SizedBox(height: 30),
            const Text("Mumbai Leaderboard",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 16),

            // 5. LEADERBOARD
            _buildLeaderboard(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMainPointsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 197, 2, 245), Color.fromARGB(255, 214, 108, 202)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white24,
            child: Icon(Icons.stars_rounded, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 12),
          const Text("290", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
          const Text("Total Civic Points", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem("12", "Issues\nReported"),
              _statItem("8", "Issues\nResolved"),
              _statItem("1", "Badges\nEarned"),
            ],
          )
        ],
      ),
    );
  }

  Widget _statItem(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white60, fontSize: 11)),
      ],
    );
  }

  Widget _buildBadgeGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: [
        _badgeCard("Civic Hero", "Reported 10+ issues", Icons.shield, Colors.amber, true, 1.0),
        _badgeCard("City Guardian", "Helped resolve 25+ issues", Icons.domain, Colors.blue, false, 0.32),
        _badgeCard("Community Champion", "Earned 500+ civic points", Icons.emoji_events, Colors.purple, false, 0.48),
        _badgeCard("Feedback Master", "Provided feedback for 20+ issues", Icons.mode_comment, Colors.green, false, 0.15),
      ],
    );
  }

  Widget _badgeCard(String title, String desc, IconData icon, Color color, bool earned, double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: earned ? color.withOpacity(0.5) : Colors.transparent),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: earned ? color : Colors.grey.shade300, size: 36),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          const SizedBox(height: 12),
          if (earned)
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 14),
                SizedBox(width: 4),
                Text("Earned", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            )
          else
            Column(
              children: [
                LinearProgressIndicator(value: progress, backgroundColor: Colors.grey.shade100, color: color, borderRadius: BorderRadius.circular(10)),
                const SizedBox(height: 4),
                Text("${(progress * 100).toInt()}% complete", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        children: [
          _activityTile("Feedback provided", "19 Dec", "+50"),
          _activityTile("Issue resolved confirmation", "18 Dec", "+30"),
          _activityTile("Issue reported", "17 Dec", "+20"),
        ],
      ),
    );
  }

  Widget _activityTile(String title, String date, String points) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.green.withOpacity(0.1), child: const Icon(Icons.add, color: Colors.green, size: 18)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: Text(points, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _buildEarnPointsGuide() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("How to Earn Points", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
          const SizedBox(height: 12),
          _guideRow(Icons.add_circle_outline, "Report an issue: 20 points"),
          _guideRow(Icons.check_circle_outline, "Confirm resolution: 30 points"),
          _guideRow(Icons.comment_outlined, "Provide feedback: 50 points"),
          _guideRow(Icons.star_outline, "Earn badges: 100 points"),
        ],
      ),
    );
  }

  Widget _guideRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 13, color: Colors.blue.shade900)),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        children: [
          _leaderboardTile(1, "Rajesh Kumar", "1250 points", false),
          _leaderboardTile(2, "Priya Sharma", "1180 points", false),
          _leaderboardTile(3, "Amit Patel", "950 points", false),
          _leaderboardTile(4, "You", "290 points", true),
        ],
      ),
    );
  }

  Widget _leaderboardTile(int rank, String name, String pts, bool isMe) {
    return Container(
      color: isMe ? Colors.green.withOpacity(0.05) : Colors.transparent,
      child: ListTile(
        leading: CircleAvatar(
          radius: 14,
          backgroundColor: isMe ? Colors.green : Colors.grey.shade100,
          child: Text(rank.toString(), style: TextStyle(color: isMe ? Colors.white : Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        title: Text(name, style: TextStyle(fontWeight: isMe ? FontWeight.bold : FontWeight.normal)),
        subtitle: const Text("Mumbai", style: TextStyle(fontSize: 11)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(pts, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Icon(Icons.emoji_events, color: rank == 1 ? Colors.amber : Colors.grey.shade300, size: 18),
          ],
        ),
      ),
    );
  }
}