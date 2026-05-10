import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  // 控制器：可以控制闪光灯、摄像头切换等
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('扫一扫'),
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
          // IconButton(
          //   icon: ValueListenableBuilder(
          //     valueListenable: controller.cameraFacingState,
          //     builder: (context, state, child) {
          //       return Icon(
          //         state == CameraFacing.front
          //             ? Icons.camera_front
          //             : Icons.camera_rear,
          //       );
          //     },
          //   ),
          //   onPressed: () => controller.switchCamera(),
          // ),
        ],
      ),
      body: Stack(
        children: [
          // 1. 扫描层
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  debugPrint('扫描到内容: $code');
                  // 扫描成功后，通常停止扫描并返回结果
                  controller.stop();
                  Navigator.pop(context, code);
                }
              }
            },
          ),
          // 2. 覆盖层（扫描框 UI）
          _buildOverlay(context),
        ],
      ),
    );
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
