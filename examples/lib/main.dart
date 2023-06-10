import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_process_indicator.dart';
import 'package:wt_actions_examples/actions/action_one.dart';
import 'package:wt_actions_examples/actions/action_three.dart';
import 'package:wt_actions_examples/actions/action_two.dart';

void main() {
  runApp(
    const ProviderScope(child: ActionButtonExamples()),
  );
}

class ActionButtonExamples extends StatelessWidget {
  const ActionButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionOne = ref.read(ActionOne.provider);
    final actionTwo = ref.read(ActionTwo.provider);
    final actionThree = ref.read(ActionThree.provider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            actionOne.component(
              background: Colors.purple,
              color: Colors.yellow,
            ),
            const SizedBox(height: 10),
            actionTwo.component(),
            const SizedBox(height: 10),
            actionOne.component(),
            const SizedBox(height: 10),
            actionThree.component(),
            const SizedBox(height: 10),
            actionThree.component(noLabel: true, color: Colors.amber),
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
          ],
        ),
      ),
      floatingActionButton: actionTwo.component(
        floating: true,
        noLabel: true,
        color: Colors.blue,
        background: Colors.yellow,
      ),
    );
  }
}
