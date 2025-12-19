import 'package:flutter/material.dart';

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({super.key});

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1A237E), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Reports",
          style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold, fontSize: 20),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF2962FF),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF2962FF),
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: const [
            Tab(text: "Pending"),
            Tab(text: "In Progress"),
            Tab(text: "Resolved"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReportList("Pending"),
          _buildReportList("In Progress"),
          _buildReportList("Resolved"),
        ],
      ),
    );
  }

  Widget _buildReportList(String status) {
    // Simulated data based on status
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 3, // Replace with your list length
      itemBuilder: (context, index) {
        return _buildReportCard(
          title: "Broken Street Light",
          category: "Infrastructure",
          date: "Oct 24, 2023",
          id: "#CIT-882${index}",
          status: status,
        );
      },
    );
  }

  Widget _buildReportCard({
    required String title,
    required String category,
    required String date,
    required String id,
    required String status,
  }) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case "Pending":
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_empty_rounded;
        break;
      case "In Progress":
        statusColor = const Color(0xFF2962FF);
        statusIcon = Icons.settings_suggest_rounded;
        break;
      default:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(statusIcon, color: statusColor, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            status,
                            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Text(id, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.category_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(category, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(width: 16),
                    const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          
          // Timeline Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("View Full Progress", style: TextStyle(color: Color(0xFF2962FF), fontWeight: FontWeight.w600, fontSize: 13)),
                const Icon(Icons.arrow_forward_rounded, color: Color(0xFF2962FF), size: 18),
              ],
            ),
          )
        ],
      ),
    );
  }
}