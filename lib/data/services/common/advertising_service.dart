import 'dart:async';

import 'package:emombti/ui/advertising/widgets/advertising_fullscreen.dart';
import 'package:flutter/material.dart';

class AdvertisingService {
  bool _isAdShowing = false;

  void showAd(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      _showAd(context);
    });
  }

  void _showAd(BuildContext context) {
    if (!context.mounted) return;

    // 2. Prevent overlapping ads
    if (_isAdShowing) return;

    _isAdShowing = true;

    FullScreenAd.show(
      context,
      title: "Premium MBTI",
      content: "Covering 80% of your screen to show you the best deals!",
      imageUrl:
          "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455_1280.jpg",
    );

    // Reset when ad is closed
    _isAdShowing = false;
  }
}
