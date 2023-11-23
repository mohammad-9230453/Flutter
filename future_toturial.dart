import "dart:io";

int milisecounds = 25;
void main() async {
  await printInLine(string: """
  async   &   await  & Future<T> && c
 

""", duration: Duration(milliseconds: milisecounds));
  getName()
      .then((value) async => await printInLine(
          string: value, duration: Duration(milliseconds: milisecounds)))
      .catchError((e) async {
    await printInLine(
        string: e.toString(), duration: Duration(milliseconds: milisecounds));
  });
  getHer()
      .then((value) async => await printInLine(
          string: value, duration: Duration(milliseconds: milisecounds)))
      .catchError((e) async {
    await printInLine(
        string: e.toString(), duration: Duration(milliseconds: milisecounds));
  });

  cleenAli().then((value) async {
    await printInLine(
        string: "ali is cleened",
        duration: Duration(milliseconds: milisecounds));
    return cleenAmir();
  }).then((value) async {
    await printInLine(
        string: "amir is cleened",
        duration: Duration(milliseconds: milisecounds));
  });

  await cleenRoom().then((value) async => await printInLine(
      string: "room is cleened",
      duration: Duration(milliseconds: milisecounds)));

  cleenReza().then((value) async => await printInLine(
      string: "reza is cleened",
      duration: Duration(milliseconds: milisecounds)));

  cleen(name: "leila", seconds: 2).then((value) async => await printInLine(
      string: "$value is cleened",
      duration: Duration(milliseconds: milisecounds)));
}

Future<void> printInLine({required String string, required Duration duration}) {
  return Future.delayed(Duration.zero).then((value) {
    for (var i = 0; i < string.length; i++) {
      stdout.write(string[i]);
      sleep(duration);
    }
    print("");
  }); //(milliseconds: string.length * duration.inMilliseconds)
}

Future<String> getName() {
  return Future.delayed(Duration(seconds: 6))
      .then((value) => "getName: mohammad");
}

Future<String> getHer() {
  return Future.delayed(Duration(seconds: 2))
      .then((value) => throw Exception("getHer: err"));
}

Future<void> cleenRoom() async {
  await printInLine(
      string: "cleenRoom: start cleening room",
      duration: Duration(milliseconds: milisecounds));
  return Future.delayed(Duration(seconds: 20));
}

Future<String> cleen({required String name, required int seconds}) async {
  await printInLine(
      string: "cleen_$name: start cleening $name",
      duration: Duration(milliseconds: milisecounds));
  return Future.delayed(Duration(seconds: seconds)).then((value) => name);
}

Future<void> cleenReza() async {
  await printInLine(
      string: "cleenReza: start cleening reza",
      duration: Duration(milliseconds: milisecounds));
  return Future.delayed(Duration(seconds: 2));
}

Future<void> cleenAli() async {
  await printInLine(
      string: "cleenAli:start cleening ali",
      duration: Duration(milliseconds: milisecounds));

  return Future.delayed(Duration(seconds: 2));
}

Future<void> cleenAmir() async {
  await printInLine(
      string: "start cleening amir",
      duration: Duration(milliseconds: milisecounds));

  return Future.delayed(Duration(seconds: 3));
}
