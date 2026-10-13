import 'package:flutter_test/flutter_test.dart';
import 'package:lifeline_flutter/format.dart';

void main() {
  test('formats times for people, not machines', () {
    expect(Fmt.minuteOfDay(9 * 60), '9:00 AM');
    expect(Fmt.minuteOfDay(19 * 60 + 30), '7:30 PM');
    expect(Fmt.countdown(const Duration(seconds: 75)), '1:15');
    expect(Fmt.duration(20), '20 seconds');
    expect(Fmt.duration(900), '15 minutes');
    final now = DateTime(2026, 10, 13, 12);
    expect(Fmt.ago(now.subtract(const Duration(seconds: 10)), now), 'just now');
    expect(Fmt.ago(now.subtract(const Duration(minutes: 5)), now), '5 min ago');
  });
}
