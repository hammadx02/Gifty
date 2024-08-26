// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black54,
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 500,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [
//                   Colors.pinkAccent.shade100,
//                   Colors.black54,
//                 ],
//               ),
//             ),
//             child: Center(
//               child: Image.asset(
//                 'assets/icons/gift.png',
//                 scale: 1.3,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           RichText(
//             text: TextSpan(
//               text: 'Welcome to ',
//               style: GoogleFonts.poppins(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//               ),
//               children: [
//                 TextSpan(
//                   text: 'Gifty',
//                   style: GoogleFonts.poppins(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.pinkAccent.shade100,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  late Animation<double> _glowAnimation;

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
    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.pinkAccent.shade100,
                      
                        Colors.black54,
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
                  angle: - pi / 12, // Rotate the gift icon by 15 degrees
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
            const SizedBox(
              height: 50,
            ),
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
            SizedBox(
              height: 20,
            ),
            Text(
              'Find out what your friends want without killing the surprise!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
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

    return List.generate(iconPaths.length, (index) {
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
    });
  }
}
