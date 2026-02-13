import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DpadUpIntent extends Intent {
  const DpadUpIntent();
}

class DpadDownIntent extends Intent {
  const DpadDownIntent();
}

class DpadLeftIntent extends Intent {
  const DpadLeftIntent();
}

class DpadRightIntent extends Intent {
  const DpadRightIntent();
}

class DpadSelectIntent extends Intent {
  const DpadSelectIntent();
}

class DpadBackIntent extends Intent {
  const DpadBackIntent();
}

class DpadBindings extends StatelessWidget {
  final Widget child;

  /// These callbacks should be implemented by the active screen.
  final VoidCallback? onUp;
  final VoidCallback? onDown;
  final VoidCallback? onLeft;
  final VoidCallback? onRight;
  final VoidCallback? onSelect;
  final VoidCallback? onBack;

  const DpadBindings({
    super.key,
    required this.child,
    this.onUp,
    this.onDown,
    this.onLeft,
    this.onRight,
    this.onSelect,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      canRequestFocus: true,
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.arrowUp): DpadUpIntent(),
          SingleActivator(LogicalKeyboardKey.arrowDown): DpadDownIntent(),
          SingleActivator(LogicalKeyboardKey.arrowLeft): DpadLeftIntent(),
          SingleActivator(LogicalKeyboardKey.arrowRight): DpadRightIntent(),

          // DPAD_CENTER / Enter / Select
          SingleActivator(LogicalKeyboardKey.enter): DpadSelectIntent(),
          SingleActivator(LogicalKeyboardKey.select): DpadSelectIntent(),
          SingleActivator(LogicalKeyboardKey.space): DpadSelectIntent(),

          // Android back (often maps to Escape)
          SingleActivator(LogicalKeyboardKey.escape): DpadBackIntent(),
          SingleActivator(LogicalKeyboardKey.goBack): DpadBackIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            DpadUpIntent: CallbackAction(onInvoke: (_) {
              onUp?.call();
              return null;
            }),
            DpadDownIntent: CallbackAction(onInvoke: (_) {
              onDown?.call();
              return null;
            }),
            DpadLeftIntent: CallbackAction(onInvoke: (_) {
              onLeft?.call();
              return null;
            }),
            DpadRightIntent: CallbackAction(onInvoke: (_) {
              onRight?.call();
              return null;
            }),
            DpadSelectIntent: CallbackAction(onInvoke: (_) {
              onSelect?.call();
              return null;
            }),
            DpadBackIntent: CallbackAction(onInvoke: (_) {
              onBack?.call();
              return null;
            }),
          },
          child: child,
        ),
      ),
    );
  }
}
