import 'package:flutter/material.dart';

class FormLoadingCoverWidget extends StatelessWidget {
  const FormLoadingCoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.7),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
