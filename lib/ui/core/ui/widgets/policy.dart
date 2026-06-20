// lib/ui/core/ui/widgets/policy.dart

import 'package:emombti/data/repositories/content/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart'; // Import the html renderer

class PolicyNativeView extends StatefulWidget {
  final String policyType;
  final VoidCallback? onLoaded;
  final ContentRepository contentRepository;

  const PolicyNativeView({
    super.key,
    required this.policyType,
    required this.contentRepository,
    this.onLoaded,
  });

  @override
  State<PolicyNativeView> createState() => _PolicyNativeViewState();
}

class _PolicyNativeViewState extends State<PolicyNativeView> {
  late Future<String> _htmlFuture;

  @override
  void initState() {
    super.initState();
    _htmlFuture = widget.contentRepository
        .getPolicyHtml(widget.policyType)
        .then((html) {
          widget.onLoaded?.call();
          return html;
        });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<String>(
      future: _htmlFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error loading policy: ${snapshot.error}'));
        }

        final rawHtml = snapshot.data ?? '';

        // Wrap with SingleChildScrollView so the native text can scroll
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Html(
            data: rawHtml,
            // Replaces your old CSS styling with type-safe Flutter Styles
            style: {
              "body": Style(
                fontFamily:
                    '-apple-system, BlinkMacSystemFont, Roboto, sans-serif',
                fontSize: FontSize(15.0),
                lineHeight: const LineHeight(1.6),
                color: isDarkMode ? Colors.grey[300] : Colors.black87,
                margin:
                    Margins.zero, // Padding handled by SingleChildScrollView
              ),
              "h1": Style(
                fontSize: FontSize(22.0),
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
                margin: Margins.only(top: 24, bottom: 12),
              ),
              "h2": Style(
                fontSize: FontSize(18.0),
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
                margin: Margins.only(top: 20, bottom: 10),
              ),
              "p": Style(margin: Margins.only(bottom: 12)),
            },
          ),
        );
      },
    );
  }
}
