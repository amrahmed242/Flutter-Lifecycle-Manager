import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'btata_service.dart';
import 'location_service.dart';

abstract class StoppableService {
  bool _serviceStoped = false;
  bool get serviceStopped => _serviceStoped;
  @mustCallSuper
  void stop() {
    _serviceStoped = true;
  }

  @mustCallSuper
  void start() {
    _serviceStoped = false;
  }
}

class LifeCycleManager extends StatefulWidget {
  final Widget child;
  final List<StoppableService> services = [];

  LifeCycleManager({Key key, @required this.child}) : super(key: key) {
    services.addAll([
      GetIt.I<BtataService>(),
      GetIt.I<LocationService>(),
    ]);
  }
  _LifeCycleManagerState createState() => _LifeCycleManagerState();

  static void registerServices() {
    // GetIt.I.registerLazySingleton<LocationService>(() => LocationService());
    GetIt.I.registerSingleton<BtataService>(BtataService());
    GetIt.I.registerSingleton<LocationService>(LocationService());
  }
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.services.forEach((service) {
      if (state == AppLifecycleState.resumed) {
        service.start();
      } else {
        service.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
