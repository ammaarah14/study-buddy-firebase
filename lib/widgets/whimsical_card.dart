import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/study_buddy_theme.dart';

class WhimsicalCard extends StatelessWidget {
  const WhimsicalCard({
    super.key,
    required this.child,
    this.color = StudyBuddyColors.paper,
    this.padding = const EdgeInsets.fromLTRB(20, 18, 20, 18),
    this.tape = false,
    this.doodle = false,
  });

  final Widget child;
  final Color color;
  final EdgeInsets padding;
  final bool tape;
  final bool doodle;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ScallopedPaperPainter(color: color, tape: tape, doodle: doodle),
      child: Padding(padding: padding, child: child),
    );
  }
}

class _ScallopedPaperPainter extends CustomPainter {
  const _ScallopedPaperPainter({required this.color, required this.tape, required this.doodle});
  final Color color;
  final bool tape;
  final bool doodle;

  @override
  void paint(Canvas canvas, Size size) {
    final shadow = Paint()..color = const Color(0x1A9B6F76);
    final fill = Paint()..color = color;
    final border = Paint()
      ..color = StudyBuddyColors.blush
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.35;

    final path = Path();
    const step = 22.0;
    const r = 5.5;
    path.moveTo(12, 0);
    for (double x = 12; x < size.width - 12; x += step) {
      path.quadraticBezierTo(x + step / 2, -r, x + step, 0);
    }
    path.lineTo(size.width - 8, 0);
    for (double y = 0; y < size.height - 10; y += step) {
      path.quadraticBezierTo(size.width + r, y + step / 2, size.width - 8, y + step);
    }
    path.lineTo(size.width - 8, size.height - 4);
    for (double x = size.width - 8; x > 12; x -= step) {
      path.quadraticBezierTo(x - step / 2, size.height + r, x - step, size.height - 4);
    }
    path.lineTo(8, size.height - 4);
    for (double y = size.height - 4; y > 0; y -= step) {
      path.quadraticBezierTo(-r, y - step / 2, 8, y - step);
    }
    path.close();

    canvas.save();
    canvas.translate(0, 4);
    canvas.drawPath(path, shadow);
    canvas.restore();
    canvas.drawPath(path, fill);
    canvas.drawPath(path, border);

    if (tape) {
      final tapePaint = Paint()..color = StudyBuddyColors.paleButter.withValues(alpha: .9);
      final tape = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(size.width * .5, 1), width: 74, height: 17),
        const Radius.circular(2),
      );
      canvas.save();
      canvas.rotate(-.015);
      canvas.drawRRect(tape, tapePaint);
      canvas.restore();
    }

    if (doodle) {
      final pen = Paint()
        ..color = StudyBuddyColors.rose
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      canvas.drawArc(Rect.fromLTWH(size.width - 34, 14, 16, 10), .1, 2.2, false, pen);
    }
  }

  @override
  bool shouldRepaint(covariant _ScallopedPaperPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.tape != tape || oldDelegate.doodle != doodle;
}

class HandDrawnLabel extends StatelessWidget {
  const HandDrawnLabel(this.text, {super.key, this.color = StudyBuddyColors.paleButter});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LabelPainter(color),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 5, 18, 7),
        child: Text(text, style: GoogleFonts.patrickHand(fontSize: 25, color: StudyBuddyColors.ink, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _LabelPainter extends CustomPainter {
  const _LabelPainter(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color;
    final path = Path()
      ..moveTo(4, 5)
      ..quadraticBezierTo(size.width * .2, 0, size.width * .4, 4)
      ..quadraticBezierTo(size.width * .7, 1, size.width - 5, 6)
      ..quadraticBezierTo(size.width, size.height * .55, size.width - 7, size.height - 5)
      ..quadraticBezierTo(size.width * .55, size.height, size.width * .25, size.height - 3)
      ..quadraticBezierTo(7, size.height, 4, 5)
      ..close();
    canvas.drawPath(path, p);
  }
  @override
  bool shouldRepaint(covariant _LabelPainter oldDelegate) => oldDelegate.color != color;
}
