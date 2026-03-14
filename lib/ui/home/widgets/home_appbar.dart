import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.onSearchChanged, this.avatarUrl});

  final ValueChanged<String>? onSearchChanged;
  final String? avatarUrl;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8.0);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final FocusNode _focusNode = FocusNode();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      // Use system surface color (usually white in Light Mode, dark grey in Dark)
      backgroundColor: colorScheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 16.0,

      // 1. Search Card (Material)
      title: AnimatedScale(
        scale: _isFocused ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Material(
          elevation: _isFocused ? 12.0 : 4.0,
          borderRadius: BorderRadius.circular(24),
          shadowColor: theme.shadowColor,
          color: colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SizedBox(
              height: 44,
              child: TextField(
                focusNode: _focusNode,
                onChanged: widget.onSearchChanged,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText:
                      'Search for personality types, characters, articles...',
                  hintMaxLines: 2,
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                    height: 1.2,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 22,
                    color: _isFocused
                        ? theme.primaryColor
                        : theme.iconTheme.color,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      // 2. Avatar (Material)
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
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
      ],
    );
  }
}
