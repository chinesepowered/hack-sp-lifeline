import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

/// Lifeline's palette: warm paper, deep teal, and clear status colors with
/// strong contrast for older eyes.
abstract final class LifelineColors {
  static const paper = Color(0xFFFBF6EE);
  static const surface = Colors.white;
  static const ink = Color(0xFF1C2A2F);
  static const muted = Color(0xFF5B6B70);
  static const line = Color(0xFFE8E0D4);
  static const teal = Color(0xFF0B6E5F);
  static const tealSoft = Color(0xFFE2F1ED);
  static const heart = Color(0xFFE8553E);

  static const ok = Color(0xFF1E8E4E);
  static const okSoft = Color(0xFFE3F4E9);
  static const awaiting = Color(0xFF2563EB);
  static const awaitingSoft = Color(0xFFE6EEFD);
  static const concern = Color(0xFFB7791F);
  static const concernSoft = Color(0xFFFBF0D9);
  static const missed = Color(0xFFD9670E);
  static const missedSoft = Color(0xFFFDEBDC);
  static const alert = Color(0xFFC62828);
  static const alertSoft = Color(0xFFFDE4E2);
  static const quiet = Color(0xFF6B7280);
  static const quietSoft = Color(0xFFEFF0F2);
}

const fontFamily = 'Atkinson Hyperlegible';

ThemeData buildLifelineTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: LifelineColors.teal,
    brightness: Brightness.light,
    surface: LifelineColors.surface,
    primary: LifelineColors.teal,
    error: LifelineColors.alert,
  );
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: LifelineColors.paper,
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: LifelineColors.ink,
      displayColor: LifelineColors.ink,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: LifelineColors.paper,
      foregroundColor: LifelineColors.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: LifelineColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: LifelineColors.line),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
        side: const BorderSide(color: LifelineColors.line, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: LifelineColors.line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: LifelineColors.line, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: LifelineColors.teal, width: 2),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      labelStyle: const TextStyle(fontFamily: fontFamily, fontSize: 14),
      side: const BorderSide(color: LifelineColors.line),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
  );
}

/// How each circle status looks and reads.
class StatusStyle {
  final Color color;
  final Color soft;
  final IconData icon;
  final String label;

  const StatusStyle(this.color, this.soft, this.icon, this.label);

  static StatusStyle of(CircleStatus status) => switch (status) {
    CircleStatus.quiet => const StatusStyle(
      LifelineColors.quiet,
      LifelineColors.quietSoft,
      Icons.schedule_rounded,
      'No check-ins yet',
    ),
    CircleStatus.ok => const StatusStyle(
      LifelineColors.ok,
      LifelineColors.okSoft,
      Icons.favorite_rounded,
      'Doing well',
    ),
    CircleStatus.awaiting => const StatusStyle(
      LifelineColors.awaiting,
      LifelineColors.awaitingSoft,
      Icons.record_voice_over_rounded,
      'Waiting for an answer',
    ),
    CircleStatus.concern => const StatusStyle(
      LifelineColors.concern,
      LifelineColors.concernSoft,
      Icons.chat_bubble_rounded,
      'May need a call',
    ),
    CircleStatus.missed => const StatusStyle(
      LifelineColors.missed,
      LifelineColors.missedSoft,
      Icons.notifications_active_rounded,
      'Missed check-in',
    ),
    CircleStatus.alert => const StatusStyle(
      LifelineColors.alert,
      LifelineColors.alertSoft,
      Icons.emergency_rounded,
      'Needs help now',
    ),
  };
}

/// Colors for an individual check-in result.
Color checkInColor(CheckInStatus status) => switch (status) {
  CheckInStatus.ok => LifelineColors.ok,
  CheckInStatus.concern => LifelineColors.concern,
  CheckInStatus.help => LifelineColors.alert,
  CheckInStatus.missed => LifelineColors.missed,
  CheckInStatus.unresponsive => LifelineColors.alert,
  CheckInStatus.pending => LifelineColors.awaiting,
};
