import 'package:flutter/material.dart';

class LoginBannerImage extends StatefulWidget {
  const LoginBannerImage({super.key});

  @override
  State<LoginBannerImage> createState() => _LoginBannerImageState();
}

class _LoginBannerImageState extends State<LoginBannerImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 15),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: RotationTransition(
        turns: _controller,
        child: ClipOval(
          // Clips the child into a circle
          child: Image.asset(
            'assets/images/Cognitive_Functions.png',
            fit: BoxFit.cover, // Use cover to ensure the circle is filled
          ),
        ),
      ),
    );
  }
}
