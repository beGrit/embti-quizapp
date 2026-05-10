import 'package:flutter/material.dart';

class AdvertisingBottomSheet extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const AdvertisingBottomSheet({
    super.key,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String content,
    required String imageUrl,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) {
          return AdvertisingBottomSheet(
            title: title,
            content: content,
            imageUrl: imageUrl,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag Handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: .3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  content,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Get Started"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenAd extends StatefulWidget {
  final String title;
  final String content;
  final String imageUrl;

  const FullScreenAd({
    super.key,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String content,
    required String imageUrl,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Advertisement",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) =>
          FullScreenAd(title: title, content: content, imageUrl: imageUrl),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
    );
  }

  @override
  State<FullScreenAd> createState() => _FullScreenAdState();
}

class _FullScreenAdState extends State<FullScreenAd>
    with SingleTickerProviderStateMixin {
  double _dragOffset = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final adHeight = size.height * 0.5; // 1/2 height
    final closeThreshold = adHeight / 2;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              _dragOffset = (_dragOffset + details.delta.dy).clamp(
                0.0,
                adHeight,
              );
            });
          },
          onVerticalDragEnd: (details) {
            if (_dragOffset > closeThreshold) {
              Navigator.of(context).pop();
            } else {
              setState(() => _dragOffset = 0);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuint,
            transform: Matrix4.translationValues(0, _dragOffset, 0),
            height: adHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            // Pass the calculated height down
            child: _buildContent(theme: Theme.of(context), maxHeight: adHeight),
          ),
        ),
      ),
    );
  }

  Widget _buildContent({required ThemeData theme, required double maxHeight}) {
    return Column(
      // Ensure the column doesn't try to be larger than its parent
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Fixed Swipe Handle
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // 2. Constrained Content Area
        Expanded(
          child: SingleChildScrollView(
            // Switch to AlwaysScrollable if content overflows 50% height
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.imageUrl,
                    // Dynamic image height relative to the dialog height
                    height: maxHeight * 0.45,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: maxHeight * 0.45,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.content,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text("Got it!"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
