import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the rotation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    // Animation for rotating the icons
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_controller);

    // Animation for the glowing effect
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black54,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.pinkAccent.shade100.withOpacity(0.80),
                        Colors.pinkAccent.shade100.withOpacity(0.050),
                      ],
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 100.0,
                    sigmaY: 100.0,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                // Gift Icon with Glow effect
                Transform.rotate(
                  angle: -pi / 12, // Rotate the gift icon by 15 degrees
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/icons/gift.png',
                      scale: 1.3,
                    ),
                  ),
                ),
                // Rotating Icons
                ..._buildRotatingIcons(),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Welcome to ',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Gifty',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent.shade100,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Find out what your friends want without killing the surprise!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 53,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.pinkAccent.withOpacity(0.60),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 53,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.pinkAccent.withOpacity(0.60),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'By tapping "create account" you agree to our ',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    children: [
                      TextSpan(
                        text: 'Privacy Policy ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      TextSpan(
                        text: 'Terms of Service',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRotatingIcons() {
    final iconPaths = [
      'assets/icons/heart.png',
      'assets/icons/smiling.png',
      'assets/icons/love_letter.png',
      'assets/icons/confetti.png',
      'assets/icons/stars.png',
    ];

    // Calculate equal angles for all icons
    final int iconCount = iconPaths.length;
    final List<double> iconAngles = List.generate(
      iconCount,
      (index) => (2 * pi / iconCount) * index,
    );

    return List.generate(
      iconPaths.length,
      (index) {
        return AnimatedBuilder(
          animation: _rotationAnimation,
          child: Image.asset(iconPaths[index], width: 40),
          builder: (context, child) {
            final angle = iconAngles[index] + _rotationAnimation.value;
            return Transform.translate(
              offset: Offset(150 * cos(angle), 150 * sin(angle)),
              child: child,
            );
          },
        );
      },
    );
  }
}
