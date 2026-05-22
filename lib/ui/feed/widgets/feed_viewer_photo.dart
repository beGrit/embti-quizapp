import 'package:flutter/material.dart';

class FeedPhotoViewScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final String heroTag; // Accepting the incoming unique tag

  const FeedPhotoViewScreen({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
    required this.heroTag,
  });

  @override
  State<FeedPhotoViewScreen> createState() => _FeedPhotoViewScreenState();
}

class _FeedPhotoViewScreenState extends State<FeedPhotoViewScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceDim,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CloseButton(color: theme.colorScheme.onSurface),
      ),
      body: PageView(
        controller: _pageController,
        children: widget.imageUrls.asMap().entries.map((entry) {
          final index = entry.key;
          final url = entry.value;
          return Center(
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              maxScale: 4.0,
              child: Hero(
                tag: index == widget.initialIndex
                    ? widget.heroTag
                    : 'temp-tag-$index',
                child: Image.network(url, fit: BoxFit.contain),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
