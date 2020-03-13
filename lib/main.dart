import 'package:flutter/material.dart';
import 'package:testapp/services/lifecycle_manager.dart';

void main() async {
  LifeCycleManager.registerServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: Text('data'),
        ),
      ),
    );
  }
}
