import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../theme.dart';

/// Lifeline's mark: a heart with a heartbeat line through it.
class LifelineMark extends StatelessWidget {
  final double size;
  final Color color;

  const LifelineMark({
    super.key,
    this.size = 32,
    this.color = LifelineColors.heart,
  });

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: CustomPaint(painter: _MarkPainter(color)),
  );
}

class _MarkPainter extends CustomPainter {
  final Color color;

  _MarkPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final heart = Path()
      ..moveTo(w * 0.5, h * 0.9)
      ..cubicTo(w * 0.1, h * 0.62, w * 0.0, h * 0.38, w * 0.12, h * 0.22)
      ..cubicTo(w * 0.26, h * 0.04, w * 0.45, h * 0.1, w * 0.5, h * 0.26)
      ..cubicTo(w * 0.55, h * 0.1, w * 0.74, h * 0.04, w * 0.88, h * 0.22)
      ..cubicTo(w * 1.0, h * 0.38, w * 0.9, h * 0.62, w * 0.5, h * 0.9)
      ..close();
    canvas.drawPath(heart, Paint()..color = color);

    final pulse = Path()
      ..moveTo(w * 0.14, h * 0.5)
      ..lineTo(w * 0.36, h * 0.5)
      ..lineTo(w * 0.44, h * 0.34)
      ..lineTo(w * 0.53, h * 0.68)
      ..lineTo(w * 0.61, h * 0.44)
      ..lineTo(w * 0.66, h * 0.5)
      ..lineTo(w * 0.86, h * 0.5);
    canvas.drawPath(
      pulse,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.075
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _MarkPainter old) => old.color != color;
}

/// The mark plus the "Lifeline" wordmark.
class LifelineLogo extends StatelessWidget {
  final double size;

  const LifelineLogo({super.key, this.size = 28});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      LifelineMark(size: size),
      SizedBox(width: size * 0.3),
      Text(
        'Lifeline',
        style: TextStyle(
          fontSize: size * 0.8,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          color: LifelineColors.ink,
        ),
      ),
    ],
  );
}

/// Rebuilds every [interval], for clocks and countdowns.
class TickerBuilder extends StatefulWidget {
  final Duration interval;
  final WidgetBuilder builder;

  const TickerBuilder({
    super.key,
    this.interval = const Duration(seconds: 1),
    required this.builder,
  });

  @override
  State<TickerBuilder> createState() => _TickerBuilderState();
}

class _TickerBuilderState extends State<TickerBuilder> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.interval, (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}

/// A titled card section.
class SectionCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget child;
  final Widget? trailing;
  final EdgeInsets padding;

  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    this.icon,
    this.trailing,
    this.padding = const EdgeInsets.fromLTRB(20, 18, 20, 20),
  });

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: LifelineColors.teal),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    ),
  );
}

/// A round avatar with initials.
class InitialsAvatar extends StatelessWidget {
  final String name;
  final double size;
  final Color color;

  const InitialsAvatar({
    super.key,
    required this.name,
    this.size = 32,
    this.color = LifelineColors.teal,
  });

  @override
  Widget build(BuildContext context) {
    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts
        .where((p) => p.isNotEmpty)
        .take(2)
        .map((p) => p[0].toUpperCase())
        .join();
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.4,
        ),
      ),
    );
  }
}

/// A soft colored pill, e.g. a status label.
class Pill extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;
  final IconData? icon;

  const Pill({
    super.key,
    required this.label,
    required this.color,
    required this.background,
    this.icon,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(999),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
        ],
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
          ),
        ),
      ],
    ),
  );
}

/// A user-facing message for any error thrown by a server call.
String friendlyError(Object error) {
  if (error is LifelineException) return error.message;
  if (error is ServerpodClientNetworkException) {
    return "Can't reach Lifeline. Check the internet connection.";
  }
  return 'Something went wrong. Please try again.';
}

void showSnack(BuildContext context, String message, {bool error = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? LifelineColors.alert : LifelineColors.ink,
      ),
    );
}
