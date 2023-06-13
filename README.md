# wt_action_button

This component uses Riverpod to make actions available throughout the application, and
manages the state of the running process, as well as stopping the action from being run
multiple times in parallel.

## Demo of using the Action Buttons

A [demo](https://tmcmaster.github.io/wt_action_button/#/) of using the Action Buttons has been 
deployd to GitHup Pages, and the demo source can be found in the examples folder.

## Action performed with no feedback

This action is run by the notifier, without the action giving feedback to the progress.


```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionTwo extends ActionButtonDefinition {
  static final log = logger(ActionTwo, level: Level.debug);

  static final provider = Provider(
    name: 'Action Two',
    (ref) => ActionTwo(ref),
  );

  ActionTwo(super.ref) : super(label: 'Action Two', icon: Icons.start);

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.run(() async {
      log.d('Doing Action Two......');
      await Future.delayed(const Duration(seconds: 1));
      log.d('Action Two Completed.');
    });
  }
}
```

## Action performed manually informing the notifier

Action is performed and manages informing the notifier when the action starts and finishes.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionOne extends ActionButtonDefinition {
  static final log = logger(ActionOne, level: Level.debug);

  static final provider = Provider(
    name: 'Action One',
    (ref) => ActionOne._(ref),
  );

  ActionOne._(super.ref)
      : super(
          label: 'Action One',
          icon: Icons.menu,
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.start();
    log.d('Doing Action One......');
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (i % 5 == 0) {
        log.d('Action one Completed.');
        notifier.finished();
        break;
      }
    }
  }
}
```

## Action performed that gives progress feedback

This is an example of creating an ActionButtonDefinition, which encapsulates that action being done,
how it is triggered, and disabling the button while the action is performed. During the execution,
the ActionButtonDefinition gives feedback as to the progress of the action being performed,

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionThree extends ActionButtonDefinition {
  static final log = logger(ActionThree, level: Level.debug);

  static final provider = Provider(
    name: 'Action Three',
    (ref) => ActionThree(ref),
  );

  ActionThree(super.ref) : super(label: 'Action Three', icon: Icons.start);

  @override
  Future<void> execute() async {
    const numberOfSteps = 10;
    final notifier = ref.read(progress.notifier);
    notifier.runWithFeedback(
      numberOfSteps: numberOfSteps,
      action: (feedback) async {
        log.d('Doing Action Three......');
        for (var i in List.generate(numberOfSteps, (i) => i)) {
          feedback('Current item: ${i + 1}');
          await Future.delayed(const Duration(seconds: 1));
        }
        log.d('Action Three Completed.');
      },
    );
  }
}
```

## Example of using an action

The following is an example of using 3 actions, creating multiple components to trigger that action.
The components can be individually configured, and when an action is trigger, any components tied to
the component is disabled until the action completes.

```dart
class DemoPage extends ConsumerWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionOne = ref.read(ActionOne.provider);
    final actionTwo = ref.read(ActionTwo.provider);
    final actionThree = ref.read(ActionThree.provider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('WT Action Button Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            actionOne.component(
              background: Colors.red,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            actionTwo.component(),
            const SizedBox(height: 10),
            actionThree.component(),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: actionThree.indicator(
                type: IndicatorType.linear,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 50,
              child: actionThree.indicator(
                type: IndicatorType.circular,
              ),
            ),
            const SizedBox(height: 10),
            actionOne.component(),
          ],
        ),
      ),
      floatingActionButton: actionTwo.component(
        floating: true,
        noLabel: true,
        color: Colors.red,
        background: Colors.yellow,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              actionOne.component(noLabel: true),
              actionTwo.component(noLabel: true),
              actionThree.component(noLabel: true),
            ],
          ),
        ),
      ),
    );
  }
}
```