import 'package:emombti/ui/core/themes/theme_util.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    controller.start();
  }

  late final MobileScannerController controller;

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = context.read<ThemeController>();
    return Theme(
      data: themeController.materialTheme.dark(),
      child: Scaffold(
        appBar: StandardAppBar(
          title: 'Scanner',
          actions: [
            // 切换手电筒
            IconButton(
              icon: ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, state, child) {
                  final TorchState torchState = state.torchState;
                  switch (torchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                    case TorchState.auto:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.unavailable:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                  }
                },
              ),
              onPressed: () => controller.toggleTorch(),
            ),
            // 切换前后摄像头
            IconButton(
              icon: ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, state, child) {
                  return Icon(
                    state.cameraDirection == CameraFacing.front
                        ? Icons.camera_front
                        : Icons.camera_rear,
                  );
                },
              ),
              onPressed: () => controller.switchCamera(),
            ),
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: (capture) {
                _onDetect(capture);
              },
            ),
            _buildOverlay(context),
          ],
        ),
      ),
    );
  }

  bool _hasScanned = false;

  void _onDetect(BarcodeCapture capture) {
    debugPrint('_onDetect');
    if (_hasScanned) return;

    final String? code = capture.barcodes.first.rawValue;

    if (code != null) {
      _hasScanned = true;

      if (context.canPop()) {
        context.pop(code);
      }
    }
  }

  Widget _buildOverlay(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: QrScannerOverlayShape(
          borderColor: Colors.blueAccent,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.7,
        ),
      ),
    );
  }
}

class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderRadius;
  final double borderLength;
  final double borderWidth;
  final double cutOutSize;

  const QrScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderRadius = 0,
    this.borderLength = 40,
    this.borderWidth = 10,
    this.cutOutSize = 250,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final height = rect.height;
    final boxWidth = cutOutSize;
    final boxHeight = cutOutSize;
    final left = (width - boxWidth) / 2;
    final top = (height - boxHeight) / 2;

    final paint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.fill;

    // 绘制四周阴影
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(rect),
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(left, top, boxWidth, boxHeight),
            Radius.circular(borderRadius),
          ),
        ),
      ),
      paint,
    );

    // 绘制四个角
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final path = Path();
    // 左上角
    path.moveTo(left, top + borderLength);
    path.lineTo(left, top);
    path.lineTo(left + borderLength, top);
    // 右上角
    path.moveTo(left + boxWidth - borderLength, top);
    path.lineTo(left + boxWidth, top);
    path.lineTo(left + boxWidth, top + borderLength);
    // 右下角
    path.moveTo(left + boxWidth, top + boxHeight - borderLength);
    path.lineTo(left + boxWidth, boxHeight + top);
    path.lineTo(left + boxWidth - borderLength, boxHeight + top);
    // 左下角
    path.moveTo(left + borderLength, top + boxHeight);
    path.lineTo(left, top + boxHeight);
    path.lineTo(left, top + boxHeight - borderLength);

    canvas.drawPath(path, borderPaint);
  }

  @override
  ShapeBorder scale(double t) => this;
}
