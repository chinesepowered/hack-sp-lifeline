import 'package:lifeline_server/src/generated/protocol.dart';
import 'package:lifeline_server/src/triage/triage.dart';
import 'package:test/test.dart';

void main() {
  group('TriageEngine', () {
    void expectLevel(String text, TriageLevel level) {
      expect(
        TriageEngine.evaluate(text).level,
        level,
        reason: '"$text" should be $level',
      );
    }

    test('everyday answers are ok', () {
      expectLevel("I'm fine, thank you dear.", TriageLevel.ok);
      expectLevel('Doing well, just had my breakfast.', TriageLevel.ok);
      expectLevel('', TriageLevel.ok);
    });

    test('aches, dizziness and low mood are a concern', () {
      expectLevel('My hip is quite sore this morning.', TriageLevel.concern);
      expectLevel('I felt a bit dizzy getting up.', TriageLevel.concern);
      expectLevel("I'm not feeling very well today.", TriageLevel.concern);
      expectLevel("I've been a bit lonely.", TriageLevel.concern);
      expectLevel('I forgot to take my pills.', TriageLevel.concern);
      expectLevel('I nearly fell on the stairs.', TriageLevel.concern);
    });

    test('falls and emergencies are urgent', () {
      expectLevel("I've fallen and I can't get up.", TriageLevel.urgent);
      expectLevel('Help me, please.', TriageLevel.urgent);
      expectLevel('I have chest pain.', TriageLevel.urgent);
      expectLevel("I'm on the floor in the kitchen.", TriageLevel.urgent);
      expectLevel('Please call an ambulance.', TriageLevel.urgent);
    });

    test('negations are respected', () {
      expectLevel('No pain today, thankfully.', TriageLevel.ok);
      expectLevel("I'm not dizzy anymore.", TriageLevel.ok);
      expectLevel("I don't need help, I'm fine.", TriageLevel.ok);
    });

    test('typographic apostrophes from speech-to-text are understood', () {
      expectLevel('I can’t get up.', TriageLevel.urgent);
    });

    test('reasons explain the decision', () {
      final triage = TriageEngine.evaluate(
        "My knee hurts and I didn't sleep.",
      );
      expect(triage.level, TriageLevel.concern);
      expect(
        triage.reasons,
        containsAll(['Mentioned pain', 'Poor sleep or exhaustion']),
      );
    });
  });
}
