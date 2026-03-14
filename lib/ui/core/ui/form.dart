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

class FormErrorMessageNotificationWidget extends StatelessWidget {
  final String errorMessage;

  final VoidCallback onPressed;

  const FormErrorMessageNotificationWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => onPressed(),
              child: const Text('Dismiss'),
            ),
          ],
        ),
      ),
    );
  }
}
