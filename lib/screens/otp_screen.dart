import 'package:flutter/material.dart';
import 'language_screen.dart';

class OtpScreen extends StatelessWidget {
  final bool isFromMobile;
  const OtpScreen({super.key, required this.isFromMobile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Add an AppBar for a cleaner "back" experience
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1A237E), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Background Decorative Elements (Consistent with Login)
          Positioned(
            top: -50,
            right: -50,
            child: _buildCircle(200, const Color(0xFFE3F2FD)),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // 2. Refined Logo Section
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2962FF).withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.shield_outlined, // Changed to shield for "Verification" feel
                      size: 45,
                      color: Color(0xFF2962FF),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // 3. Header Texts
                  const Text(
                    "Verify Code",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A237E),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 15, height: 1.5),
                        children: [
                          const TextSpan(text: "Enter the 6-digit code we sent to your "),
                          TextSpan(
                            text: isFromMobile ? "Mobile Number" : "Email Address",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 50),

                  // 4. Enhanced OTP Input
                  // Using a clean, rounded style that feels like individual boxes
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 6,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 20.0, // Creates the "box" feel
                        color: Color(0xFF2962FF),
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: "••••••",
                        hintStyle: TextStyle(color: Colors.grey.shade300, letterSpacing: 20),
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        contentPadding: const EdgeInsets.symmetric(vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Color(0xFF2962FF), width: 2),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 5. Primary Action Button
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2962FF).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LanguageScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2962FF),
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Verify & Continue",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 6. Resend Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Edit ${isFromMobile ? 'Mobile Number' : 'Email'}",
                      style: const TextStyle(
                        color: Color(0xFF1A237E),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}