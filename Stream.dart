import "dart:async";
import "dart:io";

void main() async {
  final stream = itterNum();

  final streamSubscription = await stream.listen((value) {
    print(value);
  });

  streamSubscription.cancel();
  print("1::DONE.");

  final secondStream = MyStram().streamController.stream;

  await for (final strm in secondStream) {
    print(strm);
  }
  print("2::DONE.");

  //************** */
}

Stream<int> itterNum() async* {
  int value = 0;
  while (value < 5) {
    yield value++;
    await Future.delayed(Duration(milliseconds: 1000));
  }
}

class MyStram {
  StreamController<int> streamController = StreamController();
  int value = 5;
  MyStram() {
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      if (value < 10) {
        streamController.add(value++); //OR::  streamController.sink.add(value);
      } else {
        streamController.close();
      }
    });
  }
}
