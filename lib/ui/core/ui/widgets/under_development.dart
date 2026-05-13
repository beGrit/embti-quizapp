import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnderDevelopmentScreen extends StatelessWidget {
  final String title;

  const UnderDevelopmentScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(title: title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction_rounded,
              size: 80,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              "$title is under development",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text("We're working hard to bring this feature to you!"),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.go(Routes.home),
              child: const Text("Go back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
