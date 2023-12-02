import 'dart:async';

class CounterStream{
  int _counter=0;
  final _controller = StreamController<int>();

  Stream<int> get counterStream => _controller.stream;

  void startCounter(){
    Timer.periodic(const Duration(seconds: 1), (timer){
      _counter++;
      _controller.sink.add(_counter);
    });
  }
  void dispose(){
    _controller.close();
  }
}