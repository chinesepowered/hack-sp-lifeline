import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

/// `/`: what Lifeline is, and the three ways in.
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LifelineLogo(size: 34),
                  const SizedBox(height: 56),
                  const Text(
                    'A daily voice check-in for\nloved ones who live alone.',
                    style: TextStyle(
                      fontSize: 48,
                      height: 1.1,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const SizedBox(
                    width: 720,
                    child: Text(
                      'Lifeline’s tablet asks “How are you?” in a warm, natural '
                      'voice at the times you choose. One tap, or a few spoken '
                      'words, tells the family all is well. If something is '
                      'wrong, or no one answers, everyone who cares knows '
                      'within minutes.',
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.45,
                        color: LifelineColors.muted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _EntryCard(
                        primary: true,
                        icon: Icons.play_circle_fill_rounded,
                        title: 'Try the live demo',
                        body:
                            'Both apps side by side: Rose’s tablet and her '
                            'daughter’s dashboard. No sign-up.',
                        onTap: () => Navigator.pushNamed(context, '/demo'),
                      ),
                      _EntryCard(
                        icon: Icons.family_restroom_rounded,
                        title: 'I’m family',
                        body:
                            'Create a care circle, set check-in times, and get '
                            'live alerts.',
                        onTap: () => Navigator.pushNamed(context, '/family'),
                      ),
                      _EntryCard(
                        icon: Icons.tablet_mac_rounded,
                        title: 'Set up a tablet',
                        body:
                            'Open this on the tablet at your loved one’s home '
                            'and enter the pairing code.',
                        onTap: () => Navigator.pushNamed(context, '/tablet'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 56),
                  const Text(
                    'How it works',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 18),
                  const Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _Step(
                        number: '1',
                        title: 'Lifeline asks',
                        body:
                            'At each check-in time the tablet greets them by '
                            'name, spoken by an ElevenLabs voice.',
                      ),
                      _Step(
                        number: '2',
                        title: 'They answer',
                        body:
                            'A big green button, or just talking. Speech is '
                            'transcribed and checked for worrying words.',
                      ),
                      _Step(
                        number: '3',
                        title: 'Family knows',
                        body:
                            'Dashboards update instantly. No answer? Lifeline '
                            'asks again, then alerts everyone.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 56),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Text(
                    'Built with Serverpod and Flutter · Voice by ElevenLabs · '
                    'Hosted on Serverpod Cloud',
                    style: TextStyle(color: LifelineColors.muted),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final VoidCallback onTap;
  final bool primary;

  const _EntryCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final fg = primary ? Colors.white : LifelineColors.ink;
    return SizedBox(
      width: 330,
      child: Material(
        color: primary ? LifelineColors.teal : Colors.white,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: primary ? null : Border.all(color: LifelineColors.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 36,
                  color: primary ? Colors.white : LifelineColors.teal,
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: fg,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 15.5,
                    height: 1.4,
                    color: primary ? Colors.white70 : LifelineColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String number;
  final String title;
  final String body;

  const _Step({required this.number, required this.title, required this.body});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 330,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: LifelineColors.heart,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: LifelineColors.muted,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
