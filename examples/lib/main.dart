import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_process_indicator.dart';
import 'package:wt_actions_examples/actions/action_one.dart';
import 'package:wt_actions_examples/actions/action_three.dart';
import 'package:wt_actions_examples/actions/action_two.dart';

void main() {
  runApp(
    const ProviderScope(child: DemoApp()),
  );
}

class DemoApp extends StatelessWidget {
  const DemoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const demoPage = DemoPage();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: kIsWeb
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.5,
                      child: demoPage,
                    ),
                  ),
                ],
              ),
            )
          : demoPage,
    );
  }
}

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
              state: 5,
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
