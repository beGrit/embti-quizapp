import 'package:flutter/material.dart';

import '../../core/ui/speech.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.onSearchChanged,
    this.avatarUrl,
    this.scrollScale = 1.0,
  });

  final ValueChanged<String>? onSearchChanged;
  final String? avatarUrl;
  final double scrollScale;
  static const double topMargin = 0.0;
  static const double searchBoxHeight = 60.0;
  static const double heightWithSearch =
      kToolbarHeight + topMargin + 8.0 + searchBoxHeight;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(heightWithSearch);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () => setState(() => _isFocused = _focusNode.hasFocus),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: HomeAppBar.topMargin),
      child: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 16.0,
        title: _buildTitle(theme, colorScheme),
        actions: _buildActions(theme, colorScheme),
        bottom: _buildBottom(theme, colorScheme),
      ),
    );
  }

  Widget _buildTitle(ThemeData theme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Explore MBTI',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions(ThemeData theme, ColorScheme colorScheme) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Center(
          child: Material(
            elevation: 4.0,
            shape: const CircleBorder(),
            shadowColor: theme.shadowColor,
            clipBehavior: Clip.antiAlias,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: colorScheme.primaryContainer,
              backgroundImage: widget.avatarUrl != null
                  ? NetworkImage(widget.avatarUrl!)
                  : null,
              child: widget.avatarUrl == null
                  ? Text(
                      'SF',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    ];
  }

  PreferredSize _buildBottom(ThemeData theme, ColorScheme colorScheme) {
    // Combine focus scale (1.01) with scroll scale (0.85 to 1.0)
    final double combinedScale = widget.scrollScale * (_isFocused ? 1.01 : 1.0);

    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: AnimatedScale(
              scale: combinedScale,
              duration: const Duration(milliseconds: 200),
              child: Material(
                elevation: _isFocused ? 8.0 : 4.0,
                borderRadius: BorderRadius.circular(24),
                shadowColor: theme.shadowColor,
                color: colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Center(
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _searchController,
                      onChanged: widget.onSearchChanged,
                      style: theme.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        isCollapsed: false,
                        border: InputBorder.none,
                        hintText:
                            'Search for personality types, characters, articles...',
                        hintMaxLines: 2,
                        hintStyle: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: _isFocused
                              ? theme.primaryColor
                              : theme.iconTheme.color,
                        ),
                        suffixIcon: SpeechToTextIconWidget(
                          onResult: (text) {
                            setState(() {
                              _searchController.text = text;
                            });
                            widget.onSearchChanged?.call(text);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
