# wt_actions_examples

This component uses Riverpod to make actions available throughout the application, and 
manages the state of the running process, as well as stopping the action from being run
multiple times in parallel.

## Example of an action

This is an example of creating an ActionDefinition, which encapsulates that action being done, 
how it is triggered, and disabling the button while the action is performed. 

```dart
class ActionOne extends ActionDefinition {
  static final log = logger(ActionOne, level: Level.debug);

  static final provider = Provider(
    name: 'Action One',
    (ref) => ActionOne(ref),
  );

  ActionOne(super.ref)
      : super(
          label: 'Action One',
          icon: Icons.menu,
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.start(total: 1);
    log.d('Doing Action......');
    await Future.delayed(const Duration(seconds: 5));
    log.d('Action Completed.');
    notifier.finished();
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
        color: Colors.blue,
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