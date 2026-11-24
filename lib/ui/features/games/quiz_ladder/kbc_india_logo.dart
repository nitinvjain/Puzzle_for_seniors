import 'dart:math';

import 'package:flutter/material.dart';

/// The mark for the KBC India game.
///
/// This is an original design, not the television programme's logo: that one
/// belongs to its broadcaster, so it is not reproduced here or approximated.
/// What this draws is the shape of the game itself — a prize star rising over
/// three climbing rungs — on a deep blue field with gold, which is the look of
/// an evening quiz show without being anyone's trademark.
///
/// Drawn from plain shapes rather than a glyph or an image, for three reasons:
/// it needs no font to contain the rupee sign, it needs no asset added to the
/// bundle, and it stays sharp at both sizes it is used at — 26px in the game
/// list and 240px as the faint watermark behind a card.
Widget kbcIndiaLogo(BuildContext context, double size) => SizedBox(
      width: size,
      height: size,
      child: const CustomPaint(painter: _KbcIndiaLogoPainter()),
    );

class _KbcIndiaLogoPainter extends CustomPainter {
  const _KbcIndiaLogoPainter();

  static const Color _field = Color(0xFF0B1E3A);
  static const Color _gold = Color(0xFFF5A524);
  static const Color _brightGold = Color(0xFFFFC94A);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    if (s <= 0) return;

    // The field.
    final field = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, s, s),
      Radius.circular(s * 0.24),
    );
    canvas.drawRRect(field, Paint()..color = _field);

    // Three rungs climbing to the right, bottom-aligned: the money ladder.
    final barWidth = s * 0.15;
    final gap = s * 0.06;
    final bottom = s * 0.80;
    final startX = (s - (barWidth * 3 + gap * 2)) / 2;
    const heights = [0.16, 0.26, 0.36];
    final barPaint = Paint()..color = _gold;
    for (var i = 0; i < heights.length; i++) {
      final height = s * heights[i];
      final left = startX + i * (barWidth + gap);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, bottom - height, barWidth, height),
          Radius.circular(barWidth * 0.3),
        ),
        barPaint,
      );
    }

    // The prize, sitting just above the tallest rung. The inner radius is
    // deliberately large for a star: at 26px in the game list a slimmer one
    // breaks up into thin legs and stops reading as a star at all.
    canvas.drawPath(
      _star(Offset(s * 0.5, s * 0.26), s * 0.165, s * 0.088),
      Paint()..color = _brightGold,
    );
  }

  /// A five-pointed star: ten points alternating between [outer] and [inner]
  /// radius, starting at the top.
  Path _star(Offset centre, double outer, double inner) {
    final path = Path();
    for (var i = 0; i < 10; i++) {
      final radius = i.isEven ? outer : inner;
      final angle = -pi / 2 + i * pi / 5;
      final point = Offset(
        centre.dx + radius * cos(angle),
        centre.dy + radius * sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    return path..close();
  }

  @override
  bool shouldRepaint(_KbcIndiaLogoPainter oldDelegate) => false;
}
