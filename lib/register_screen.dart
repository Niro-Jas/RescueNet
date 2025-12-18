import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart'; // Handles the popup
import 'dart:io';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _handleCamera() async {
    // 1. Check if we have permission
    var status = await Permission.camera.status;

    if (status.isPermanentlyDenied) {
      openAppSettings(); // Takes user to phone settings if they clicked "Never ask again"
      return;
    }

    if (!status.isGranted) {
      status = await Permission.camera.request(); // Shows the "Allow" popup
    }

    if (status.isGranted) {
      _pickImage();
    } else {
      _showSnackBar("Camera permission is required to take photos.");
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (photo != null) {
        setState(() {
          _selectedImage = File(photo.path);
        });
      }
    } catch (e) {
      _showSnackBar("Error opening camera: $e");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF0F9FF), Color(0xFFFFFFFF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildProgressBar(),
              const SizedBox(height: 40),
              const Text("Add Photo", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
              const SizedBox(height: 40),
              _buildUploadCard(),
              const Spacer(),
              if (_selectedImage != null) _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
          const Text("Report Issue", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stepCircle("1", true),
          _stepLine(),
          _stepCircle("2", false),
          _stepLine(),
          _stepCircle("3", false),
        ],
      ),
    );
  }

  Widget _buildUploadCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))],
        ),
        child: Column(
          children: [
            Container(
              width: 130, height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(20),
                image: _selectedImage != null ? DecorationImage(image: FileImage(_selectedImage!), fit: BoxFit.cover) : null,
              ),
              child: _selectedImage == null ? const Icon(Icons.camera_alt_outlined, color: Color(0xFF2962FF), size: 50) : null,
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: _handleCamera,
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              label: Text(_selectedImage == null ? "Open Camera" : "Change Photo"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2962FF),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ElevatedButton(
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A237E),
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget _stepCircle(String t, bool active) => Container(
    width: 35, height: 35,
    decoration: BoxDecoration(color: active ? const Color(0xFF2962FF) : Colors.grey[300], shape: BoxShape.circle),
    child: Center(child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.black54, fontWeight: FontWeight.bold))),
  );

  Widget _stepLine() => Expanded(child: Container(height: 2, color: Colors.grey[300], margin: const EdgeInsets.symmetric(horizontal: 10)));
}