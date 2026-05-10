import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GravityCanvasBackground extends StatefulWidget {
  const GravityCanvasBackground({super.key});

  @override
  State<GravityCanvasBackground> createState() =>
      _GravityCanvasBackgroundState();
}

class _GravityCanvasBackgroundState extends State<GravityCanvasBackground>
    with SingleTickerProviderStateMixin {
  double offsetX = 0;
  double offsetY = 0;
  double _lastFilteredX = 0;
  double _lastFilteredY = 0;
  StreamSubscription? _subscription;

  // 2. 自动动画控制器
  late AnimationController _autoMoveController;

  @override
  void initState() {
    super.initState();

    // 3. 初始化自动巡航动画 (比如 10 秒绕一圈)
    _autoMoveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _subscription = accelerometerEventStream(
      samplingPeriod: const Duration(milliseconds: 16),
    ).listen(_onAccelerometerEvent);
  }

  void _onAccelerometerEvent(AccelerometerEvent event) {
    const double alpha = 0.85;
    const double sensitivity = 20.0;

    _lastFilteredX = alpha * _lastFilteredX + (1 - alpha) * event.x;
    _lastFilteredY = alpha * _lastFilteredY + (1 - alpha) * event.y;

    double targetX = _lastFilteredX * sensitivity;
    double targetY = _lastFilteredY * sensitivity;

    if ((targetX - offsetX).abs() > 0.5 || (targetY - offsetY).abs() > 0.5) {
      setState(() {
        offsetX = targetX;
        offsetY = targetY;
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _autoMoveController.dispose(); // 销毁控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _autoMoveController,
      builder: (context, child) {
        // 4. 计算自动位移 (利用正弦/余弦函数跑圆圈)
        // radius 控制自动移动的范围大小
        const double autoMoveRadius = 30.0;
        double autoX =
            math.cos(_autoMoveController.value * 2 * math.pi) * autoMoveRadius;
        double autoY =
            math.sin(_autoMoveController.value * 2 * math.pi) * autoMoveRadius;

        // 5. 叠加两个位移
        double finalX = offsetX + autoX;
        double finalY = offsetY + autoY;

        return ClipRect(
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOutCubic,
              // 使用叠加后的坐标
              transform: Matrix4.translationValues(finalX, finalY, 0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Transform.scale(
                      scale: 2,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BackgroundItemsPainter extends CustomPainter {
  final double offsetX;
  final double offsetY;

  BackgroundItemsPainter({required this.offsetX, required this.offsetY});

  @override
  void paint(Canvas canvas, Size size) {
    final List<Map<String, dynamic>> nodes = [
      {'label': 'ISTJ', 'color': Colors.blue},
      {'label': 'ESTJ', 'color': Colors.amber},
      {'label': 'ISFJ', 'color': Colors.indigo},
      {'label': 'ENFP', 'color': Colors.green},
      {'label': 'INTJ', 'color': Colors.purple},
      {'label': 'ENTP', 'color': Colors.orange},
      {'label': 'INFJ', 'color': Colors.teal},
      {'label': 'ESFP', 'color': Colors.pink},
    ];

    // 1. 配置圆形布局参数
    final Offset centerOfCanvas = Offset(size.width / 2, size.height / 2);
    final double layoutRadius =
        math.min(size.width, size.height) * 0.35; // 布局圆的半径

    // 2. 计算每个节点的坐标
    List<Offset> points = [];
    for (int i = 0; i < nodes.length; i++) {
      // 将 360 度平均分配
      double angle =
          (i * 2 * math.pi / nodes.length) -
          (math.pi / 2); // 减去 pi/2 让第一个点从正上方开始

      double x = centerOfCanvas.dx + layoutRadius * math.cos(angle) + offsetX;
      double y = centerOfCanvas.dy + layoutRadius * math.sin(angle) + offsetY;
      points.add(Offset(x, y));
    }

    // 3. 绘制背景连接线 (可选)
    final Paint linePaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1;

    // 绘制圆环路径线
    canvas.drawCircle(
      centerOfCanvas + Offset(offsetX, offsetY),
      layoutRadius,
      linePaint..style = PaintingStyle.stroke,
    );

    // 4. 绘制节点
    for (int i = 0; i < points.length; i++) {
      final node = nodes[i];
      final center = points[i];
      final color = node['color'] as Color;

      // 绘制圆形背景
      canvas.drawCircle(center, 30, Paint()..color = color.withOpacity(0.8));

      // 绘制文字
      final textPainter = TextPainter(
        text: TextSpan(
          text: node['label'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(
          center.dx - (textPainter.width / 2),
          center.dy - (textPainter.height / 2),
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant BackgroundItemsPainter oldDelegate) {
    return oldDelegate.offsetX != offsetX || oldDelegate.offsetY != offsetY;
  }
}
