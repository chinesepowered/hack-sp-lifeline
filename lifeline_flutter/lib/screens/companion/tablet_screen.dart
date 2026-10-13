import 'package:flutter/material.dart';

import '../../client.dart';
import '../../state/stores.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import 'companion_view.dart';

/// `/tablet`: pairs this browser as a loved one's companion screen once,
/// then shows the companion view from then on.
class TabletScreen extends StatefulWidget {
  const TabletScreen({super.key});

  @override
  State<TabletScreen> createState() => _TabletScreenState();
}

class _TabletScreenState extends State<TabletScreen> {
  String? _token = CompanionStore.token;

  @override
  Widget build(BuildContext context) {
    final token = _token;
    if (token != null) {
      return Scaffold(
        body: CompanionView(
          deviceToken: token,
          onUnpaired: () {
            CompanionStore.clear();
            if (mounted) setState(() => _token = null);
          },
        ),
      );
    }
    return Scaffold(
      body: PairPanel(onPaired: (token) => setState(() => _token = token)),
    );
  }
}

class PairPanel extends StatefulWidget {
  final ValueChanged<String> onPaired;

  const PairPanel({super.key, required this.onPaired});

  @override
  State<PairPanel> createState() => _PairPanelState();
}

class _PairPanelState extends State<PairPanel> {
  final _code = TextEditingController();
  final _label = TextEditingController(text: 'Living room tablet');
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    _label.dispose();
    super.dispose();
  }

  Future<void> _pair() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final result = await client.companion.pair(_code.text, _label.text);
      CompanionStore.save(result.deviceToken, result.lovedOneName);
      widget.onPaired(result.deviceToken);
    } catch (e) {
      setState(() => _error = friendlyError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: LifelineMark(size: 64)),
                const SizedBox(height: 18),
                const Text(
                  'Set up this tablet',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter the 6-digit pairing code shown in the family app. '
                  'You only need to do this once.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: LifelineColors.muted),
                ),
                const SizedBox(height: 26),
                TextField(
                  controller: _code,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  style: const TextStyle(
                    fontSize: 40,
                    letterSpacing: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Pairing code',
                    counterText: '',
                    errorText: _error,
                  ),
                  onSubmitted: (_) => _pair(),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _label,
                  decoration: const InputDecoration(
                    labelText: 'Name this screen',
                  ),
                ),
                const SizedBox(height: 22),
                FilledButton(
                  onPressed: _busy ? null : _pair,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: fontFamily,
                    ),
                  ),
                  child: _busy
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Connect'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
