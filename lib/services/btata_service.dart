import 'lifecycle_manager.dart';

class BtataService extends StoppableService {
  @override
  void start() {
    super.start();
    print('BtataService started🍉');
    // start subscription again
  }

  @override
  void stop() {
    super.stop();
    print('BtataService stopped');

    // cancel stream subscription
  }
}
