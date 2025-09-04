import 'package:e_voting_app/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Icon
            const Icon(
              Icons.how_to_vote,
              size: 100,
              color: Colors.white,
            ).animate().fadeIn(duration: 1.seconds).scale(delay: 500.ms),

            const SizedBox(height: 20),

            // App Title
            Text(
              "E-Voting App",
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).animate().slideY(begin: -1, duration: 1.seconds),

            const SizedBox(height: 20),

            // Loading Indicator
            const CircularProgressIndicator(
              color: Colors.white,
            ).animate().fadeIn(duration: 1.seconds),
          ],
        ),
      ),
    );
  }
}
