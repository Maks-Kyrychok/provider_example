import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(home: MainScreen()));
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => Model(),
        child: const ViewWidget(),
      );
}

class ViewWidget extends StatelessWidget {
  const ViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<Model>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider exemple'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BoxWidget(),
            Switch(
              value: context.watch<Model>().isNotifiable,
              onChanged: (bool toggle) {
                model.toggleNotification(isNotifiable: toggle);
                model.getColor();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: context.watch<Model>().generatedColor,
    );
  }
}

class Model extends ChangeNotifier {
  final Random random = Random();
  Color generatedColor = const Color.fromARGB(255, 26, 89, 139);

  void getColor() {
    generatedColor = Color.fromARGB(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
    );
    notifyListeners();
  }

  bool isNotifiable = false;

  void toggleNotification({bool isNotifiable = true}) {
    this.isNotifiable = isNotifiable;
    notifyListeners();
  }
}
