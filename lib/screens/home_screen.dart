import 'package:flutter/material.dart';
import 'report_issue_screen.dart'; 
import 'profile_screen.dart'; 
import 'rewards_screen.dart';
import 'notifications_screen.dart'; 
import 'my_reports_screen.dart'; // 1. ADDED THIS IMPORT

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Profile Data - Shared with ProfileScreen
  String userName = "User";
  String userLocation = "Mumbai";

  Future<void> _navigateToReport() async {
    setState(() => _selectedIndex = 1);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReportIssueScreen()),
    );
    if (result == 'return_home' || result == null) {
      setState(() {
        _selectedIndex = 0; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2962FF).withOpacity(0.03),
              ),
            ),
          ),
          _buildCurrentScreen(),
        ],
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF2962FF),
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          elevation: 0,
          onTap: (index) {
            if (index == 1) {
              _navigateToReport();
            } else {
              setState(() => _selectedIndex = index);
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_rounded), label: 'Report'),
            BottomNavigationBarItem(icon: Icon(Icons.stars_rounded), label: 'Rewards'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_selectedIndex) {
      case 0: return _buildHomeContent();
      case 2: return const RewardsScreen(); 
      case 3:
        return ProfileScreen(
          currentName: userName,
          currentLocation: userLocation,
          onSave: (newName, newLoc) {
            setState(() {
              userName = newName;
              userLocation = newLoc;
            });
          },
          onBackToHome: () => setState(() => _selectedIndex = 0),
        );
      default: return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2962FF).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_rounded, color: Color(0xFF2962FF), size: 14),
                          const SizedBox(width: 4),
                          Text(userLocation, style: const TextStyle(color: Color(0xFF2962FF), fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Hello, $userName 👋",
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF1A237E), letterSpacing: -0.5),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200, width: 1),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)
                          ],
                        ),
                        child: const Icon(Icons.notifications_none_rounded, color: Color(0xFF1A237E), size: 26),
                      ),
                      Positioned(
                        right: 12,
                        top: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            Row(
              children: [
                _buildStatCard("12", "Reported", Icons.edit_document, const Color(0xFF2962FF)),
                const SizedBox(width: 12),
                _buildStatCard("8", "Resolved", Icons.check_circle_rounded, Colors.green),
                const SizedBox(width: 12),
                _buildStatCard("240", "Points", Icons.stars_rounded, Colors.orange),
              ],
            ),
            
            const SizedBox(height: 35),
            const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 16),
            
            GestureDetector(
              onTap: _navigateToReport,
              child: _buildActionCard("Report an Issue", "Fast report civic problems", Icons.add_business_rounded, Colors.redAccent),
            ),

            // 2. WRAPPED "MY REPORTS" IN GESTURE DETECTOR
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyReportsScreen()),
                );
              },
              child: _buildActionCard("My Reports", "Track your submission status", Icons.analytics_rounded, const Color(0xFF2962FF)),
            ),
            
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 2),
              child: _buildActionCard("Civic Rewards", "Redeem your points for badges", Icons.workspace_premium_rounded, Colors.amber.shade700),
            ),
            
            const SizedBox(height: 30),
            
            const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 4))],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.done_all_rounded, color: Colors.green, size: 20),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pothole Fixed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1A237E))),
                        Text("Location: Sector 42, Mumbai", style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ),
                  const Text("Just now", style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ),

            const SizedBox(height: 35),
            const Text("Nearby Issues Map", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 16),
            _buildMapPreview(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMapPreview() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 4))],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              color: Colors.blue.shade50,
              width: double.infinity,
              height: double.infinity,
              child: Opacity(
                opacity: 0.5,
                child: Image.network(
                  'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?q=80&w=1000&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Position(child: Icon(Icons.location_on, color: Colors.red, size: 30), top: 40, left: 100),
          const Position(child: Icon(Icons.location_on, color: Colors.orange, size: 25), top: 100, left: 220),
          const Position(child: Icon(Icons.location_on, color: Colors.green, size: 28), top: 70, left: 180),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map_rounded, size: 18),
                label: const Text("Explore Full Map"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2962FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color themeColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: themeColor.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 8))
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: themeColor, size: 28),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1A237E))),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color iconBg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconBg.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: iconBg),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E), fontSize: 16)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade300, size: 16),
      ),
    );
  }
}

class Position extends StatelessWidget {
  final Widget child;
  final double? top, left, right, bottom;
  const Position({super.key, required this.child, this.top, this.left, this.right, this.bottom});
  @override
  Widget build(BuildContext context) {
    return Positioned(top: top, left: left, right: right, bottom: bottom, child: child);
  }
}