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
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  late AnimationController _bounceControllerGoogle;
  late AnimationController _bounceControllerCreate;
  late Animation<double> _bounceAnimationGoogle;
  late Animation<double> _bounceAnimationCreate;

  @override
  void initState() {
    super.initState();

    // Initialize the rotation controller
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Animation for rotating the icons
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_rotationController);

    // Initialize the bounce controllers
    _bounceControllerGoogle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _bounceControllerCreate = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Bounce animations
    _bounceAnimationGoogle = Tween<double>(begin: 1.0, end: 0.95)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_bounceControllerGoogle);

    _bounceAnimationCreate = Tween<double>(begin: 1.0, end: 0.95)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_bounceControllerCreate);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _bounceControllerGoogle.dispose();
    _bounceControllerCreate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
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
                Transform.rotate(
                  angle: -pi / 12,
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
            height: 50,
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
                GestureDetector(
                  onTap: () {
                    _bounceControllerGoogle.forward().then((value) {
                      _bounceControllerGoogle.reverse();
                    });
                  },
                  child: ScaleTransition(
                    scale: _bounceAnimationGoogle,
                    child: Container(
                      height: 53,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.withOpacity(0.010),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.pinkAccent.withOpacity(0.60),
                        ),
                      ),
                      child: Center(
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/icons/google.png',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Continue with Google',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    _bounceControllerCreate.forward().then((value) {
                      _bounceControllerCreate.reverse();
                    });
                  },
                  child: ScaleTransition(
                    scale: _bounceAnimationCreate,
                    child: Container(
                      height: 53,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.shade200.withOpacity(0.80),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Create account',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
          child: SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              iconPaths[index],
            ),
          ),
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
