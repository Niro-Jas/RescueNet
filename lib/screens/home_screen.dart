import 'package:flutter/material.dart';
import 'report_issue_screen.dart'; 
import 'profile_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Profile Data - Shared with ProfileScreen (Operations Kept Original)
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
      // Consistent Background Decorations
      body: Stack(
        children: [
          // Background Decorative Circle
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
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), activeIcon: Icon(Icons.grid_view_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_rounded), label: 'Report'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: 'Alerts'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_selectedIndex) {
      case 0: return _buildHomeContent();
      case 2: return const Center(child: Text("Notifications Screen Coming Soon"));
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
            // --- ENHANCED HEADER ---
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
                  onTap: () => setState(() => _selectedIndex = 3),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF2962FF).withOpacity(0.2), width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFFE3F2FD),
                      child: Icon(Icons.person_rounded, color: Color(0xFF2962FF), size: 28),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // --- ENHANCED STAT CARDS ---
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
            
            // --- ENHANCED ACTION CARDS ---
            GestureDetector(
              onTap: _navigateToReport,
              child: _buildActionCard("Report an Issue", "Fast report civic problems", Icons.add_business_rounded, Colors.redAccent),
            ),
            _buildActionCard("My Reports", "Track your submission status", Icons.analytics_rounded, const Color(0xFF2962FF)),
            _buildActionCard("Civic Rewards", "Redeem your points for badges", Icons.workspace_premium_rounded, Colors.amber.shade700),
            
            const SizedBox(height: 30),
            
            // --- ENHANCED RECENT ACTIVITY ---
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
            const SizedBox(height: 40),
          ],
        ),
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