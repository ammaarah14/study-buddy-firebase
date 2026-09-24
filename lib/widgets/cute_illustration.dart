import 'package:flutter/material.dart';
import '../theme/study_buddy_theme.dart';

class StudyBunny extends StatelessWidget {
  const StudyBunny({super.key, this.size = 150});
  final double size;
  @override
  Widget build(BuildContext context) => SizedBox(width: size * 1.65, height: size, child: CustomPaint(painter: _BunnyPainter()));
}

class _BunnyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill;

    // Books.
    p.color = StudyBuddyColors.rose;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(5, size.height * .72, size.width * .78, size.height * .17), const Radius.circular(8)), p);
    p.color = StudyBuddyColors.butter;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(20, size.height * .57, size.width * .72, size.height * .17), const Radius.circular(8)), p);
    p.color = StudyBuddyColors.paper;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(33, size.height * .43, size.width * .66, size.height * .16), const Radius.circular(8)), p);

    // Bunny body/head.
    p.color = const Color(0xFFFFFAF5);
    canvas.drawOval(Rect.fromLTWH(size.width * .39, size.height * .22, size.width * .36, size.height * .50), p);
    canvas.drawOval(Rect.fromLTWH(size.width * .44, 0, size.width * .12, size.height * .34), p);
    canvas.drawOval(Rect.fromLTWH(size.width * .61, size.height * .04, size.width * .12, size.height * .31), p);
    p.color = StudyBuddyColors.blush;
    canvas.drawOval(Rect.fromLTWH(size.width * .47, size.height * .08, size.width * .055, size.height * .18), p);
    canvas.drawOval(Rect.fromLTWH(size.width * .65, size.height * .12, size.width * .055, size.height * .18), p);

    final line = Paint()..color = StudyBuddyColors.deepRose..strokeWidth = 2..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawCircle(Offset(size.width * .50, size.height * .46), 2.8, Paint()..color = StudyBuddyColors.deepRose);
    canvas.drawCircle(Offset(size.width * .67, size.height * .46), 2.8, Paint()..color = StudyBuddyColors.deepRose);
    canvas.drawArc(Rect.fromLTWH(size.width * .56, size.height * .46, 13, 10), 0, 1.7, false, line);

    // Mug and pencils.
    p.color = StudyBuddyColors.paleButter;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * .83, size.height * .45, size.width * .17, size.height * .29), const Radius.circular(8)), p);
    canvas.drawArc(Rect.fromLTWH(size.width * .94, size.height * .50, size.width * .15, size.height * .18), -1.4, 2.8, false, line);
    p.color = StudyBuddyColors.deepRose;
    canvas.drawRect(Rect.fromLTWH(size.width * .86, size.height * .20, 5, size.height * .31), p);
    p.color = StudyBuddyColors.sage;
    canvas.drawRect(Rect.fromLTWH(size.width * .93, size.height * .24, 5, size.height * .28), p);
    p.color = StudyBuddyColors.rose;
    canvas.drawRect(Rect.fromLTWH(size.width * .98, size.height * .16, 5, size.height * .35), p);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
