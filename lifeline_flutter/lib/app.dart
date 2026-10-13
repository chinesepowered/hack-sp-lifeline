import 'package:flutter/material.dart';

import 'screens/companion/tablet_screen.dart';
import 'screens/demo/demo_screen.dart';
import 'screens/family/family_home.dart';
import 'screens/landing_screen.dart';
import 'theme.dart';

class LifelineApp extends StatelessWidget {
  const LifelineApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Lifeline',
    debugShowCheckedModeBanner: false,
    theme: buildLifelineTheme(),
    onGenerateRoute: (settings) {
      final path = Uri.parse(settings.name ?? '/').path;
      final Widget page = switch (path) {
        '/demo' => const DemoScreen(),
        '/tablet' => const TabletScreen(),
        '/family' => const FamilyHome(),
        _ => const LandingScreen(),
      };
      return MaterialPageRoute(builder: (_) => page, settings: settings);
    },
  );
}
