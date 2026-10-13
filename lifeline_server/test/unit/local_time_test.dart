import 'package:lifeline_server/src/checkins/phrases.dart';
import 'package:lifeline_server/src/common/local_time.dart';
import 'package:test/test.dart';

void main() {
  group('LocalTime', () {
    test('converts a local check-in time to a UTC cron expression', () {
      // 09:00 in New York in summer (UTC-4) is 13:00 UTC.
      expect(LocalTime.dailyCron(9 * 60, -240), '0 13 * * *');
      // 07:30 in Tokyo (UTC+9) is 22:30 UTC the day before.
      expect(LocalTime.dailyCron(7 * 60 + 30, 540), '30 22 * * *');
      // 19:00 in London in winter (UTC+0).
      expect(LocalTime.dailyCron(19 * 60, 0), '0 19 * * *');
    });

    test('finds the latest and next occurrence of a slot', () {
      final now = DateTime.utc(2026, 10, 13, 12, 0);
      // 09:00 local at UTC-4 = 13:00 UTC: today's has not happened yet.
      expect(
        LocalTime.latestOccurrence(9 * 60, -240, nowUtc: now),
        DateTime.utc(2026, 10, 12, 13, 0),
      );
      expect(
        LocalTime.nextOccurrence(9 * 60, -240, nowUtc: now),
        DateTime.utc(2026, 10, 13, 13, 0),
      );
    });

    test('speaks times naturally', () {
      expect(LocalTime.spokenTime(DateTime(2026, 1, 1, 9)), "9 o'clock");
      expect(LocalTime.spokenTime(DateTime(2026, 1, 1, 19, 5)), '7:05');
      expect(LocalTime.label(19 * 60 + 30), '7:30 PM');
      expect(LocalTime.greeting(8), 'Good morning');
      expect(LocalTime.greeting(20), 'Good evening');
    });
  });

  group('Phrases.familyNames', () {
    test('joins first names naturally', () {
      expect(Phrases.familyNames([]), 'your family');
      expect(Phrases.familyNames(['Sam Lee']), 'Sam');
      expect(Phrases.familyNames(['Sam', 'David']), 'Sam and David');
      expect(
        Phrases.familyNames(['Sam', 'David', 'Priya']),
        'Sam, David and Priya',
      );
    });
  });
}
