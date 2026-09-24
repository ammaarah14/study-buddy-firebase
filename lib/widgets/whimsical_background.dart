import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/study_buddy_theme.dart';

class WhimsicalBackground extends StatelessWidget {
  const WhimsicalBackground({super.key, required this.child, this.scrollable = false});
  final Widget child;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final content = Stack(
      children: [
        const Positioned.fill(child: CustomPaint(painter: _BackgroundPainter())),
        child,
      ],
    );
    return scrollable ? SingleChildScrollView(child: content) : content;
  }
}

class _BackgroundPainter extends CustomPainter {
  const _BackgroundPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill;
    p.color = StudyBuddyColors.background;
    canvas.drawRect(Offset.zero & size, p);

    // Very clean decorative waves, matching the reference rather than scattered shapes.
    final pinkWave = Path()..moveTo(0, size.height - 38);
    for (var x = 0.0; x <= size.width + 80; x += 120) {
      pinkWave.quadraticBezierTo(x + 60, size.height - 82, x + 120, size.height - 38);
    }
    pinkWave.lineTo(size.width, size.height);
    pinkWave.lineTo(0, size.height);
    pinkWave.close();
    p.color = StudyBuddyColors.blush.withValues(alpha: .28);
    canvas.drawPath(pinkWave, p);

    final yellowWave = Path()..moveTo(size.width * .35, size.height);
    for (var x = size.width * .35; x <= size.width + 100; x += 150) {
      yellowWave.quadraticBezierTo(x + 75, size.height - 45, x + 150, size.height - 5);
    }
    yellowWave.lineTo(size.width, size.height);
    yellowWave.close();
    p.color = StudyBuddyColors.paleButter.withValues(alpha: .85);
    canvas.drawPath(yellowWave, p);

    _star(canvas, Offset(size.width * .86, 38), 10);
    _star(canvas, Offset(size.width * .62, 58), 6);
    _heart(canvas, Offset(size.width * .82, 82), 8);
  }

  void _star(Canvas canvas, Offset c, double s) {
    final path = Path();
    for (var i = 0; i < 10; i++) {
      final r = i.isEven ? s : s * .36;
      final a = -math.pi / 2 + i * math.pi / 5;
      final pt = Offset(c.dx + math.cos(a) * r, c.dy + math.sin(a) * r);
      if (i == 0) { path.moveTo(pt.dx, pt.dy); } else { path.lineTo(pt.dx, pt.dy); }
    }
    path.close();
    canvas.drawPath(path, Paint()..color = StudyBuddyColors.butter);
  }

  void _heart(Canvas canvas, Offset c, double s) {
    final path = Path()
      ..moveTo(c.dx, c.dy + s)
      ..cubicTo(c.dx - s * 1.5, c.dy, c.dx - s, c.dy - s, c.dx, c.dy - s * .2)
      ..cubicTo(c.dx + s, c.dy - s, c.dx + s * 1.5, c.dy, c.dx, c.dy + s);
    canvas.drawPath(path, Paint()..color = StudyBuddyColors.rose);
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) => false;
}
