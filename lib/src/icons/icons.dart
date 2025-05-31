import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:system_fonts/system_fonts.dart';

// Switched to CustomPaint icons by https://github.com/esDotDev

class GlyphIcon extends StatelessWidget {
  final int codePoint;
  final Color color;
  final double size;
  final Alignment alignment;

  const GlyphIcon({
    Key? key,
    required this.codePoint,
    required this.color,
    this.size = 12,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SystemFonts().loadFont('SegoeIcons'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data != null) {
          return Align(
            alignment: alignment,
            child: Text(
              String.fromCharCode(codePoint),
              style: TextStyle(
                fontFamily: snapshot.data!,
                fontSize: size,
                color: color,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

/// Close
class CloseIcon extends StatelessWidget {
  final Color color;
  CloseIcon({Key? key, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      GlyphIcon(codePoint: 0xe921, color: color);
}

/// Maximize
class MaximizeIcon extends StatelessWidget {
  final Color color;
  MaximizeIcon({Key? key, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      GlyphIcon(codePoint: 0xe921, color: color);
}

/// Restore
class RestoreIcon extends StatelessWidget {
  final Color color;
  RestoreIcon({
    Key? key,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      GlyphIcon(codePoint: 0xe921, color: color);

}

/// Minimize
class MinimizeIcon extends StatelessWidget {
  final Color color;
  MinimizeIcon({Key? key, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      GlyphIcon(codePoint: 0xe921, color: color);
}


Paint getPaint(Color color, [bool isAntiAlias = false]) => Paint()
  ..color = color
  ..style = PaintingStyle.stroke
  ..isAntiAlias = isAntiAlias
  ..strokeWidth = 1;
