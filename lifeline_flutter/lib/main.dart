import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';
import 'client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Clean URLs (/demo, /tablet, /family); the server's FlutterRoute falls
  // back to index.html for them.
  usePathUrlStrategy();
  // Always build the accessibility tree: Lifeline is for people who may
  // rely on screen readers.
  SemanticsBinding.instance.ensureSemantics();
  await initializeClient();
  runApp(const LifelineApp());
}
