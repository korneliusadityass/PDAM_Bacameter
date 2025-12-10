import 'dart:ui';

import 'package:flutter/material.dart';

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DottedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
    this.borderRadius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // agar titik ujung bulat

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rRect);
    final Iterable<PathMetric> pathMetrics = path.computeMetrics();

    for (PathMetric metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final Tangent? startTangent = metric.getTangentForOffset(distance);
        if (startTangent != null) {
          final double endOffset = distance + dashWidth;
          final Offset endPosition = endOffset < metric.length
              ? metric.getTangentForOffset(endOffset)?.position ??
                    startTangent.position
              : metric.getTangentForOffset(metric.length)?.position ??
                    startTangent.position;

          canvas.drawLine(startTangent.position, endPosition, paint);
        }
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
