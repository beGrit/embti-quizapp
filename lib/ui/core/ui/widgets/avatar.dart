import 'package:flutter/material.dart';

class MusicVisualizerAvatar extends StatefulWidget {
  final Widget child;
  final double size;
  final bool isPlaying;

  const MusicVisualizerAvatar({
    super.key,
    required this.child,
    this.size = 46.0,
    this.isPlaying = true,
  });

  @override
  State<MusicVisualizerAvatar> createState() => _MusicVisualizerAvatarState();
}

class _MusicVisualizerAvatarState extends State<MusicVisualizerAvatar>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Slow, smooth rotation for a "floating" feel
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    if (widget.isPlaying) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The "Cloud" Glow Layer
          RotationTransition(
            turns: _controller,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.blue.withOpacity(0.4),
                    Colors.white.withOpacity(
                      0.9,
                    ), // The "bright" edge of the cloud
                    Colors.lightBlueAccent.withOpacity(0.3),
                    Colors.white.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Soft outer blur to make it look "misty"
          Container(
            width: widget.size - 2,
            height: widget.size - 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.15),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),

          // The Static Avatar
          SizedBox(
            width: widget.size - 8,
            height: widget.size - 8,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
