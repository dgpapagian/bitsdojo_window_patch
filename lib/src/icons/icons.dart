import 'dart:math';
import 'package:flutter/widgets.dart';

// Switched to CustomPaint icons by https://github.com/esDotDev

class GlyphIcon extends StatelessWidget {
  final String glyph;
  final Color color;
  final double size;
  final Alignment alignment;

  const GlyphIcon({
    Key? key,
    required this.glyph,
    required this.color,
    this.size = 12,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        glyph,
        style: TextStyle(
          fontFamily: 'Segoe UI Symbol',
          fontSize: size,
          color: color,
        ),
      ),
    );
  }
}

/// Close
class CloseIcon extends StatelessWidget {
  final Color color;
  CloseIcon({Key? key, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topLeft,
        child: Stack(children: [
          // Use rotated containers instead of a painter because it renders slightly crisper than a painter for some reason.
          Transform.rotate(
              angle: pi * .25,
              child:
                  Center(child: Container(width: 14, height: 1, color: color))),
          Transform.rotate(
              angle: pi * -.25,
              child:
                  Center(child: Container(width: 14, height: 1, color: color))),
        ]),
      );
}

/// Maximize
class MaximizeIcon extends StatelessWidget {
  final Color color;
  MaximizeIcon({Key? key, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) => _AlignedPaint(_MaximizePainter(color));
}

class _MaximizePainter extends _IconPainter {
  _MaximizePainter(Color color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    const double radius = 1.0;
    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(0, 0, size.width - 1, size.height - 1),
      Radius.circular(radius),
    );
    canvas.drawRRect(rRect, p);
  }
}

/// Restore
class RestoreIcon extends StatelessWidget {
  final Color color;
  RestoreIcon({
    Key? key,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => _AlignedPaint(_RestorePainter(color));
}

class _RestorePainter extends _IconPainter {
  _RestorePainter(Color color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    const double radius = 2.0;
    final RRect backWindow = RRect.fromRectAndRadius(
      Rect.fromLTRB(2, 0, size.width, size.height - 2),
      Radius.circular(radius),
    );

    final RRect frontWindow = RRect.fromRectAndRadius(
      Rect.fromLTRB(0, 2, size.width - 2, size.height),
      Radius.circular(radius),
    );

    final Path backPath = Path()..addRRect(backWindow);
    final Path frontPath = Path()..addRRect(frontWindow);

    final Path clippedBackPath = Path.combine(
      PathOperation.difference,
      backPath,
      frontPath,
    );

    canvas.drawPath(clippedBackPath, p);
    canvas.drawRRect(frontWindow, p);
  }
}

/// Minimize
class MinimizeIcon extends StatelessWidget {
  final Color color;
  MinimizeIcon({Key? key, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      GlyphIcon(glyph: String.fromCharCode(0xe921), color: color);
}

class _MinimizePainter extends _IconPainter {
  _MinimizePainter(Color color) : super(color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), p);
  }
}

/// Helpers
abstract class _IconPainter extends CustomPainter {
  _IconPainter(this.color);
  final Color color;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AlignedPaint extends StatelessWidget {
  const _AlignedPaint(this.painter, {Key? key}) : super(key: key);
  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: CustomPaint(size: Size(10, 10), painter: painter));
  }
}

Paint getPaint(Color color, [bool isAntiAlias = false]) => Paint()
  ..color = color
  ..style = PaintingStyle.stroke
  ..isAntiAlias = isAntiAlias
  ..strokeWidth = 1;
