import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

// --- 1. 粒子物理模型 ---
class BubbleParticle {
  Offset position;
  Offset velocity;
  double size;
  Color color;
  double opacity = 1.0;
  double lifeTime = 1.0; // 1.0 -> 0.0

  BubbleParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.color,
  });

  void update() {
    position += velocity;
    velocity *= 0.95; // 空气阻力
    velocity += const Offset(0, 0.08); // 微弱重力
    lifeTime -= 0.02;
    opacity = lifeTime.clamp(0.0, 1.0);
  }
}

// --- 2. 主组件 ---
class AvatarCirclePaint extends StatefulWidget {
  const AvatarCirclePaint({super.key});

  @override
  State<AvatarCirclePaint> createState() => _AvatarCirclePaintState();
}

class _AvatarCirclePaintState extends State<AvatarCirclePaint>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _personalities = [
    {'label': 'INTJ', 'color': Colors.deepPurple},
    {'label': 'INTP', 'color': Colors.indigo},
    {'label': 'ENTJ', 'color': Colors.purple},
    {'label': 'ENTP', 'color': Colors.deepPurpleAccent},
    {'label': 'INFJ', 'color': Colors.teal},
    {'label': 'INFP', 'color': Colors.green},
    {'label': 'ENFJ', 'color': Colors.lightGreen},
    {'label': 'ENFP', 'color': Colors.lime},
    {'label': 'ISTJ', 'color': Colors.blue},
    {'label': 'ISFJ', 'color': Colors.cyan},
    {'label': 'ESTJ', 'color': Colors.blueAccent},
    {'label': 'ESFJ', 'color': Colors.lightBlue},
    {'label': 'ISTP', 'color': Colors.orange},
    {'label': 'ISFP', 'color': Colors.amber},
    {'label': 'ESTP', 'color': Colors.deepOrange},
    {'label': 'ESFP', 'color': Colors.pink},
  ];

  late List<Map<String, dynamic>> _currentNodes;
  late List<Map<String, dynamic>> _oldNodes;
  late List<int> _nodeStages;
  final List<BubbleParticle> _particles = [];
  final Set<int> _explodedIndices = {}; // 防止重复爆炸

  late AnimationController _controller;
  Timer? _autoSwitchTimer;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _currentNodes = _getNewBatch();
    _oldNodes = [];
    _assignStages();

    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(seconds: 4), // 4秒一轮爆炸
        )..addListener(() {
          _updatePhysics();
        });

    // 每 7 秒自动换一批
    _autoSwitchTimer = Timer.periodic(
      const Duration(seconds: 7),
      (timer) => _nextBatch(),
    );
  }

  void _assignStages() {
    _nodeStages = List.generate(8, (_) => _random.nextInt(4));
    _explodedIndices.clear();
  }

  List<Map<String, dynamic>> _getNewBatch() {
    return (List<Map<String, dynamic>>.from(
      _personalities,
    )..shuffle()).take(8).toList();
  }

  void _updatePhysics() {
    if (_particles.isEmpty && _controller.isAnimating == false) return;
    setState(() {
      for (var p in _particles) {
        p.update();
      }
      _particles.removeWhere((p) => p.lifeTime <= 0);
    });
  }

  void _triggerExplosion(Offset pos, Color color) {
    for (int i = 0; i < 15; i++) {
      double angle = _random.nextDouble() * 2 * math.pi;
      double speed = 1.0 + _random.nextDouble() * 5.0;
      _particles.add(
        BubbleParticle(
          position: pos,
          velocity: Offset(math.cos(angle) * speed, math.sin(angle) * speed),
          size: 2.0 + _random.nextDouble() * 4.0,
          color: color,
        ),
      );
    }
  }

  void _nextBatch() {
    if (!mounted) return;
    _controller.reset();
    setState(() {
      _oldNodes = List.from(_currentNodes);
      _currentNodes = _getNewBatch();
      _assignStages();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _autoSwitchTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(400, 400),
      painter: BubbleExplosionPainter(
        oldNodes: _oldNodes,
        newNodes: _currentNodes,
        nodeStages: _nodeStages,
        progress: _controller.value,
        particles: _particles,
        explodedIndices: _explodedIndices,
        onExplode: _triggerExplosion,
      ),
    );
  }
}

// --- 3. 核心绘制逻辑 ---
class BubbleExplosionPainter extends CustomPainter {
  final List<Map<String, dynamic>> oldNodes;
  final List<Map<String, dynamic>> newNodes;
  final List<int> nodeStages;
  final double progress;
  final List<BubbleParticle> particles;
  final Set<int> explodedIndices;
  final Function(Offset, Color) onExplode;

  BubbleExplosionPainter({
    required this.oldNodes,
    required this.newNodes,
    required this.nodeStages,
    required this.progress,
    required this.particles,
    required this.explodedIndices,
    required this.onExplode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double baseRadius = math.min(size.width, size.height) * 0.35;

    // 绘制碎片层
    for (var p in particles) {
      final pPaint = Paint()..color = p.color.withOpacity(p.opacity);
      canvas.drawCircle(p.position, p.size, pPaint);
    }

    // 绘制旧节点（气泡）
    if (progress < 1.0 && oldNodes.isNotEmpty) {
      for (int i = 0; i < oldNodes.length; i++) {
        double stageStart = nodeStages[i] * 0.25;
        double t = ((progress - stageStart) / 0.25).clamp(0.0, 1.0);

        double angle = (i * 2 * math.pi / oldNodes.length) - (math.pi / 2);
        Offset pos =
            center +
            Offset(math.cos(angle) * baseRadius, math.sin(angle) * baseRadius);

        if (t > 0 && t < 1.0) {
          // 刚进入该阶段时触发爆炸回调
          if (!explodedIndices.contains(i) && t > 0.1) {
            explodedIndices.add(i);
            Future.microtask(() => onExplode(pos, oldNodes[i]['color']));
          }
          // 气泡逐渐消失并略微放大（像破裂前的膨胀）
          final paint = Paint()
            ..color = (oldNodes[i]['color'] as Color).withOpacity(1.0 - t);
          canvas.drawCircle(pos, 30 * (1.0 + t * 0.2), paint);
        } else if (t == 0) {
          // 还没轮到爆炸的显示原样
          canvas.drawCircle(
            pos,
            30,
            Paint()..color = (oldNodes[i]['color'] as Color).withOpacity(0.8),
          );
          _drawLabel(canvas, pos, oldNodes[i]['label'], 1.0);
        }
      }
    }

    // 绘制新节点（平滑浮现）
    if (progress > 0.0 || oldNodes.isEmpty) {
      for (int i = 0; i < newNodes.length; i++) {
        double stageStart = nodeStages[i] * 0.25;
        double t = ((progress - stageStart) / 0.25).clamp(0.0, 1.0);

        if (oldNodes.isEmpty) t = 1.0; // 首次加载直接显示

        double angle = (i * 2 * math.pi / newNodes.length) - (math.pi / 2);
        double radius = baseRadius * (0.8 + t * 0.2);
        Offset pos =
            center + Offset(math.cos(angle) * radius, math.sin(angle) * radius);

        final paint = Paint()
          ..color = (newNodes[i]['color'] as Color).withOpacity(0.8 * t);
        canvas.drawCircle(pos, 30 * t, paint);
        if (t > 0.5) _drawLabel(canvas, pos, newNodes[i]['label'], t);
      }
    }
  }

  void _drawLabel(Canvas canvas, Offset pos, String text, double opacity) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.white.withOpacity(opacity),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
