import 'package:flutter/material.dart';

class LoginLogo extends StatefulWidget {
  const LoginLogo({super.key});

  @override
  State<LoginLogo> createState() => _LoginLogoState();
}

class _LoginLogoState extends State<LoginLogo> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .4),
            blurRadius: 10,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset('assets/images/logo_v3.png', fit: BoxFit.cover),
      ),
    );
  }
}

class AnimatedLoginLogo extends StatefulWidget {
  const AnimatedLoginLogo({super.key});

  @override
  State<AnimatedLoginLogo> createState() => _AnimatedLoginLogoState();
}

class _AnimatedLoginLogoState extends State<AnimatedLoginLogo> {
  double _currentHeight = 200.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _currentHeight = 400.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 3000),
      curve: Curves.elasticOut,
      height: _currentHeight,
      width: double.infinity,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // AvatarCirclePaint(),
          LoginLogo(),
        ],
      ),
    );
  }
}
