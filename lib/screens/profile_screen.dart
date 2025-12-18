import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentLocation;
  final Function(String, String) onSave;
  final VoidCallback onBackToHome;

  const ProfileScreen({
    super.key,
    required this.currentName,
    required this.currentLocation,
    required this.onSave,
    required this.onBackToHome,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  late TextEditingController nameController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    locationController = TextEditingController(text: widget.currentLocation);
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Softer, lighter background
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(color: Color(0xFF2D3142), fontWeight: FontWeight.w900, letterSpacing: -0.5)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: widget.onBackToHome,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 25),
            
            // Impact Section Header
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8, bottom: 12),
                child: Text("Your Community Impact ✨", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF2D3142))),
              ),
            ),
            
            _buildImpactSection(), // The newly designed spaced section
            
            const SizedBox(height: 30),
            
            // Settings List
            _buildMenuTile(Icons.chat_bubble_outline_rounded, "Language", "English", Colors.pinkAccent),
            _buildMenuTile(Icons.notifications_active_outlined, "Notifications", "On", Colors.orangeAccent),
            _buildMenuTile(Icons.favorite_border_rounded, "Support Civic Connect", "Help us grow", Colors.redAccent),
            _buildMenuTile(Icons.security_rounded, "Privacy & Safety", "Terms of use", Colors.blueAccent),
            
            const SizedBox(height: 40),
            
            // Soft Logout Button
            TextButton(
              onPressed: () {},
              child: const Text("Log Out", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const Text("v1.0.0", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE0E7FF), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 48,
                  backgroundColor: Color(0xFFF0F4FF),
                  child: Icon(Icons.face_retouching_natural_rounded, size: 50, color: Color(0xFF6366F1)),
                ),
              ),
              Container(
                height: 30, width: 30,
                decoration: const BoxDecoration(color: Color(0xFF4CAF50), shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!isEditing) ...[
            Text(widget.currentName, 
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF2D3142))),
            Text(widget.currentLocation, 
              style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => isEditing = true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ] else ...[
            _buildCuteTextField(nameController, "Your Name"),
            const SizedBox(height: 12),
            _buildCuteTextField(locationController, "Where do you live?"),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => setState(() => isEditing = false),
                    child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onSave(nameController.text, locationController.text);
                      setState(() => isEditing = false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Save", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCuteTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildImpactSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildImpactCard("12", "Reported", Icons.edit_location_alt_rounded, const Color(0xFFEEF2FF), const Color(0xFF6366F1)),
        _buildImpactCard("8", "Resolved", Icons.task_alt_rounded, const Color(0xFFECFDF5), const Color(0xFF10B981)),
        _buildImpactCard("240", "Points", Icons.stars_rounded, const Color(0xFFFFFBEB), const Color(0xFFF59E0B)),
      ],
    );
  }

  Widget _buildImpactCard(String val, String label, IconData icon, Color bgColor, Color iconColor) {
    // Each stat is now its own "Cute Card" instead of one big dark block
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 3, // Perfect spacing
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: iconColor.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: iconColor)),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white), // Glassy look
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF2D3142))),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}