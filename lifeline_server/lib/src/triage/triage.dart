import '../generated/protocol.dart';

/// The outcome of triaging a spoken answer.
class Triage {
  final TriageLevel level;

  /// Human-readable reasons, e.g. "Mentioned pain (sore)".
  final List<String> reasons;

  const Triage(this.level, this.reasons);

  @override
  String toString() => 'Triage($level, $reasons)';
}

class _Rule {
  final TriageLevel level;
  final String reason;
  final RegExp pattern;

  /// Whether a preceding "not", "no", "didn't"... cancels the match, as in
  /// "I didn't fall" or "no pain today".
  final bool negatable;

  _Rule(this.level, this.reason, String pattern, {this.negatable = true})
    : pattern = RegExp(pattern, caseSensitive: false);
}

/// Deterministic, explainable triage of a loved one's spoken answer.
///
/// This is intentionally rule based rather than a black-box model: families
/// can see exactly why something was flagged, and the rules err on the side
/// of raising an alert for anything that sounds like a fall or an emergency.
abstract final class TriageEngine {
  static final _rules = <_Rule>[
    // Urgent: emergencies.
    _Rule(
      TriageLevel.urgent,
      'Possible fall',
      r"\b(i'?ve fallen|i have fallen|i fell|i'?ve had a fall|had a fall|took a fall|fallen (down|over)|on the floor)\b",
    ),
    _Rule(
      TriageLevel.urgent,
      "Can't get up",
      r"\b(can'?t|cannot|can not|unable to) (get|stand) up\b",
      negatable: false,
    ),
    _Rule(
      TriageLevel.urgent,
      'Asked for help',
      r"\b(help me|i need help|need (some )?help|please help|call (an |the )?ambulance|call 911|call 999|emergency)\b",
    ),
    _Rule(
      TriageLevel.urgent,
      'Chest pain or breathing trouble',
      r"\b(chest pain|pain in my chest|can'?t breathe|cannot breathe|short of breath|trouble breathing|struggling to breathe)\b",
    ),
    _Rule(
      TriageLevel.urgent,
      'Possible stroke signs',
      r"\b(can'?t (move|feel) my (arm|leg|face)|face (is )?drooping|slurring)\b",
      negatable: false,
    ),
    _Rule(
      TriageLevel.urgent,
      'Heavy bleeding',
      r"\b(bleeding (a lot|badly|heavily)|lots of blood|won'?t stop bleeding)\b",
    ),

    // Concern: worth a call from the family today.
    _Rule(
      TriageLevel.concern,
      'Near fall',
      r'\b(almost fell|nearly fell|tripped|stumbled|slipped|lost my balance)\b',
    ),
    _Rule(
      TriageLevel.concern,
      'Mentioned pain',
      r'\b(pain|painful|hurts?|hurting|sore|aches?|aching)\b',
    ),
    _Rule(
      TriageLevel.concern,
      'Feeling dizzy',
      r'\b(dizzy|light-?headed|faint|woozy|unsteady)\b',
    ),
    _Rule(
      TriageLevel.concern,
      'Feeling unwell',
      r'\b(sick|unwell|poorly|nause(a|ous)|vomit(ing)?|threw up|fever)\b',
    ),
    _Rule(
      TriageLevel.concern,
      'Feeling unwell',
      r"(\bnot|n't)\s+(feeling\s+)?(very |so |too )?(well|great|good|ok|okay|myself)\b",
      negatable: false,
    ),
    _Rule(
      TriageLevel.concern,
      'Poor sleep or exhaustion',
      r'\b(exhausted|very tired|so tired|worn out)\b',
    ),
    _Rule(
      TriageLevel.concern,
      'Poor sleep or exhaustion',
      r"\b(didn'?t sleep|couldn'?t sleep|no sleep|barely slept)\b",
      negatable: false,
    ),
    _Rule(
      TriageLevel.concern,
      'Low mood',
      r'\b(lonely|sad|depressed|anxious|worried|scared|frightened|upset|feeling (low|down))\b',
    ),
    _Rule(
      TriageLevel.concern,
      'Medication issue',
      r"\b(forgot (to take )?my (pills|tablets|medication|medicine|meds)|ran out of (my )?(pills|tablets|medication|medicine|meds)|missed my (pills|tablets|medication|medicine|meds))\b",
      negatable: false,
    ),
    _Rule(
      TriageLevel.concern,
      'Sounds confused',
      r"\b(confused|can'?t remember|don'?t know where i am)\b",
      negatable: false,
    ),
    _Rule(
      TriageLevel.concern,
      'Not eating',
      r"\b(not eating|no appetite|haven'?t eaten|not hungry)\b",
      negatable: false,
    ),
  ];

  static final _negators = RegExp(
    r"\b(not|no|never|didn'?t|don'?t|haven'?t|hasn'?t|isn'?t|wasn'?t|without|nothing)\b",
    caseSensitive: false,
  );

  /// Triage [transcript]. Empty input is treated as "ok" by the caller only
  /// if it chooses to; this returns [TriageLevel.ok] with no reasons.
  static Triage evaluate(String transcript) {
    // Speech-to-text may use typographic apostrophes ("can’t").
    final text = transcript.trim().replaceAll('\u2019', "'");
    if (text.isEmpty) return const Triage(TriageLevel.ok, []);

    var level = TriageLevel.ok;
    final reasons = <String>[];

    for (final rule in _rules) {
      for (final match in rule.pattern.allMatches(text)) {
        if (rule.negatable && _isNegated(text, match.start)) continue;
        if (!reasons.contains(rule.reason)) reasons.add(rule.reason);
        if (_rank(rule.level) > _rank(level)) level = rule.level;
        break;
      }
    }

    if (reasons.isEmpty) reasons.add('Sounds well');
    return Triage(level, reasons);
  }

  /// True when one of the three words before [start] negates the match.
  static bool _isNegated(String text, int start) {
    final before = text.substring(0, start).trim().split(RegExp(r'\s+'));
    final window = before
        .skip(before.length > 3 ? before.length - 3 : 0)
        .join(' ');
    return _negators.hasMatch(window);
  }

  static int _rank(TriageLevel level) => switch (level) {
    TriageLevel.ok => 0,
    TriageLevel.concern => 1,
    TriageLevel.urgent => 2,
  };
}
