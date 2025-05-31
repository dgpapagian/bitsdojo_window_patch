import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:system_fonts/system_fonts.dart';

class GlyphIcon extends StatelessWidget {
  final int codePoint;
  final Color color;
  final double size;
  final Alignment alignment;

  const GlyphIcon({
    Key? key,
    required this.codePoint,
    required this.color,
    this.size = 10,
    this.alignment = Alignment.center,
  }) : super(key: key);

  static final Future<String?> _fontFuture =
      SystemFonts().loadFont('SegoeIcons');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _fontFuture,
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
          return Align(
            alignment: alignment,
            child: SizedBox(
              height: size,
              width: size,
            ),
          );
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
      GlyphIcon(codePoint: 0xe8bb, color: color); //ChromeClose
}

/// Maximize
class MaximizeIcon extends StatelessWidget {
  final Color color;
  MaximizeIcon({Key? key, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      GlyphIcon(codePoint: 0xe922, color: color); //ChromeMaximize
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
      GlyphIcon(codePoint: 0xe923, color: color); //ChromeRestore
}

/// Minimize
class MinimizeIcon extends StatelessWidget {
  final Color color;
  MinimizeIcon({Key? key, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      GlyphIcon(codePoint: 0xe921, color: color); //ChromeMinimize
}
