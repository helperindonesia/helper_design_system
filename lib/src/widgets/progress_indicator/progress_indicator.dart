import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

export 'progress_indicator.dart';

/**
 * Created by DhytoDev on 01/07/21.
 * Email : dhytodev@gmail.com
 */
class ProgressIndicator extends StatelessWidget {
  final double percentage;

  const ProgressIndicator({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: ProgressIndicatorPainter(percentage),
    );
  }
}

class ProgressIndicatorPainter extends CustomPainter {
  final double percentage;

  ProgressIndicatorPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = Color(0xFFFEF3EA)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Paint complete = Paint()
      ..color = HelperColors.orange
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), line);

    canvas.drawLine(Offset(0, size.height),
        Offset(size.width * (percentage / 100), size.height), complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
