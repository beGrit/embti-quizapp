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
              color: Colors.grey.withOpacity(0.3),
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
    final size = MediaQuery.of(context).size;
    final adHeight = size.height * 0.5;
    final closeThreshold = adHeight / 2;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              // Dragging down increases _dragOffset
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
              // BOUNCE: Resetting offset triggers AnimatedContainer's curve
              setState(() {
                _dragOffset = 0;
              });
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.elasticOut, // The "Bounce" feel
            transform: Matrix4.translationValues(0, _dragOffset, 0),
            height: adHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: _buildContent(theme: Theme.of(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildContent({required ThemeData theme}) {
    return Column(
      children: [
        // Swipe handle
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            // Prevent internal scrolling from eating the swipe-down gesture
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.imageUrl,
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // FIX: Gracefully handle Handshake/Network errors
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 280,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.content,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
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
