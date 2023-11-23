import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff16E5A7))
              .copyWith(secondary: Color(0xff16E5A7)),
          useMaterial3: true,
          inputDecorationTheme:
              InputDecorationTheme(border: OutlineInputBorder())),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<StudentData> _studentsData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            isExtended: true,
            onPressed: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return _AddStudentForm(
                    studentData: _studentsData,
                  );
                },
              ));
              setState(() {});
            },
            label: Container(
              child: Center(
                child: Row(
                  children: [Icon(Icons.add), Text("Add Student")],
                ),
              ),
            )),
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(
            "Android Expert",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        body: FutureBuilder(
          future: getStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              _studentsData = snapshot.data!;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _Student(data: _studentsData[index]);
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  strokeCap: StrokeCap.round,
                  color: Colors.black,
                ),
              );
            }
          },
        ));
  }
}

class _AddStudentForm extends StatelessWidget {
  List<StudentData> studentData;
  _AddStudentForm({required this.studentData});
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _courseController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          onPressed: () async {
            try {
              StudentData student = await saveStudent(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  course: _courseController.text,
                  score: int.tryParse(_scoreController.text) == null
                      ? 0
                      : int.parse(_scoreController.text));
              Navigator.pop(context, student);
              // studentData.insert(0, student);

              // Navigator.pop(context);
            } catch (e) {
              print(e.toString());
            }
          },
          label: Container(
            child: Center(
              child: Row(
                children: [
                  Icon(Icons.check),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Save")
                ],
              ),
            ),
          )),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Add New Student",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(label: Text("First Name")),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(label: Text("Last Name")),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _courseController,
              decoration: InputDecoration(label: Text("Course")),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _scoreController,
              decoration: InputDecoration(label: Text("Score")),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class _Student extends StatelessWidget {
  final StudentData data;
  const _Student({required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 84,
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05))
          ]),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary),
            child: Text(
              data.first_name.characters.first,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w900,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.first_name + ' ' + data.last_name),
                SizedBox(
                  height: 8,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey[200]),
                    child: Text(
                      data.course,
                      style: TextStyle(fontSize: 10),
                    )),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bar_chart_rounded,
                color: Colors.grey[400],
              ),
              Text(
                data.score.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

class StudentListView extends StatefulWidget {
  const StudentListView({
    super.key,
  });

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  ScrollController scrollController = ScrollController();
  bool isLoadeDatas = false;
  late List<StudentData> students;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoadeDatas = false;
    });
    getStudents().then((value) {
      students = value;
      isLoadeDatas = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoadeDatas
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              Positioned.fill(
                  child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Container(
                    // padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
                    margin: EdgeInsets.fromLTRB(5, 12, 5, 0),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.5), blurRadius: 1)
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 60,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(50, 187, 218, 243),
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                "${students[index].first_name[0]} ${students[index].last_name[0]}",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(172, 4, 83, 148)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${students[index].first_name} ${students[index].last_name}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(20, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text(students[index].course),
                                ),
                              )
                            ],
                          )),
                          Column(
                            children: [
                              Icon(
                                Icons.bar_chart_rounded,
                                size: 30,
                              ),
                              Text(students[index].score.toString())
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  child: Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.onPrimary),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () {
                          // Navigator.of(context).push();
                        },
                        child: Text("+ Add Student")),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  width: 52,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.onPrimary),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () {
                        setState(() {
                          scrollController.position.animateTo(0,
                              duration: Duration(
                                  milliseconds:
                                      (scrollController.position.pixels / 10)
                                          .toInt()),
                              curve: Curves.linear);
                        });
                      },
                      child: Text("^")),
                ),
              ),
            ],
          );
  }
}
