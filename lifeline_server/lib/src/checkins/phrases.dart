import '../common/local_time.dart';

/// What the companion says. Short sentences, plain words, one idea at a time:
/// easy to follow for someone with hearing loss or memory problems.
abstract final class Phrases {
  static String prompt(String name, DateTime local) {
    final greeting = LocalTime.greeting(local.hour);
    final time = LocalTime.spokenTime(local);
    if (local.hour >= 4 && local.hour < 12) {
      return "$greeting, $name! It's $time. How are you feeling this morning? "
          "Tap the green button if you're okay, or just tell me.";
    }
    if (local.hour >= 12 && local.hour < 17) {
      return '$greeting, $name. Just checking in. How is your day going? '
          "Tap the green button if you're okay, or just tell me.";
    }
    return '$greeting, $name. Before you settle in tonight, how are you '
        "feeling? Tap the green button if you're okay, or just tell me.";
  }

  static String reprompt(String name) =>
      "$name, are you there? Please tap the big green button to let your "
      "family know you're okay.";

  static String okReply(String name, String family) =>
      "Wonderful. Thank you, $name! I'll let $family know you're doing well.";

  static String concernReply(String name, String family) =>
      'Thank you for telling me, $name. '
      "I've let $family know, so they can check in with you today.";

  static String helpReply(String name, String family) =>
      "Okay, $name. I'm alerting $family right now. "
      'Stay where you are. Help is on the way.';

  static String didNotCatch(String name) =>
      "Sorry, $name, I didn't catch that. You can tap the green button if "
      "you're okay.";

  static String unresponsiveNotice(String name, String family) =>
      "$name, I haven't heard from you, so I'm letting $family know.";

  static String acknowledged(String name, String helper) =>
      '$name, $helper has seen your alert and is on it. Help is coming.';

  static String familyMessage(String fromName, String text) =>
      'Here is a message from $fromName. $text';

  static String voicePreview(String voiceName, String lovedOneName) =>
      "Hello $lovedOneName, I'm $voiceName. I'll check in with you each day, "
      'and keep your family in the loop.';

  /// "Sam", "Sam and David", "Sam, David and Priya", or "your family".
  static String familyNames(List<String> names) {
    final firstNames = names
        .map((n) => n.trim().split(RegExp(r'\s+')).first)
        .where((n) => n.isNotEmpty)
        .toSet()
        .toList();
    if (firstNames.isEmpty) return 'your family';
    if (firstNames.length == 1) return firstNames.first;
    final last = firstNames.removeLast();
    return '${firstNames.join(', ')} and $last';
  }
}
