import 'dart:math';

import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http_crud/data.dart';
import 'package:http_crud/data/repo/repository.dart';
import 'package:http_crud/data/source/hive.task.source.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

const taskBoxName = 'tasks';
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff5C0AFF),
    // Theme.of(context).colorScheme.primaryContainer,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(taskBoxName);
  runApp(Provider(
      create: (context) => Repository<Task>(
          localDataSource: HiveDataSource(box: Hive.box(taskBoxName))),
      child: MyApp()));
}

const Color primaryColor = Color(0xff794CFF);

const secondaryTextColor = Color(0xffAFBED0);
const primaryTextColor = Color(0xff1D2830);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
            TextTheme(headlineSmall: TextStyle(fontWeight: FontWeight.bold))),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(color: secondaryTextColor),
          prefixIconColor: secondaryTextColor,
        ),
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          primaryContainer: Color(0xff5C0AFF),
          background: Color(0xffF3F5F8),
          onBackground: primaryTextColor,
          onSurface: primaryTextColor,
          secondary: primaryColor,
          onSecondary: Colors.white,
          onPrimary: Colors.white,
        ),

        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final heder_color = Colors.blue[900];
  final TextEditingController searchTextEditingController =
      TextEditingController();
  final ValueNotifier<String> searchNotifire = ValueNotifier('');
  @override
  Widget build(BuildContext context) {
    // final box = Hive.box<Task>(taskBoxName);
    final themeData = Theme.of(context);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return EditTaskPage(
                  task: Task(),
                );
              },
            ));
          },
          clipBehavior: Clip.hardEdge,
          label: const Row(
            children: [
              Text("Add New Task"),
              SizedBox(
                width: 5,
              ),
              Icon(CupertinoIcons.add),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 102,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeData.colorScheme.primary,
                      themeData.colorScheme.primaryContainer
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "To Do List",
                            style: themeData.textTheme.headlineSmall!.apply(
                              color: themeData.colorScheme.onPrimary,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.smiley_fill,
                            color: themeData.colorScheme.onPrimary,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 38,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: themeData.colorScheme.onPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: themeData.colorScheme.primary,
                                blurRadius: 20,
                              )
                            ]),
                        child: TextField(
                          onChanged: (value) {
                            searchNotifire.value = value;
                          },
                          controller: searchTextEditingController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.search),
                            hintText: "Search Task...",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "To do",
                          style: themeData.textTheme.headlineSmall!
                              .apply(fontSizeFactor: 0.8),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 70,
                          height: 3,
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.primary,
                              borderRadius: BorderRadius.circular(1.5)),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      final repository = Provider.of<Repository<Task>>(context);
                      repository.deleteAll(
                          searchKeyword: searchTextEditingController.text);
                    },
                    elevation: 0,
                    textColor: secondaryTextColor,
                    color: const Color(0xffEAEFF5),
                    child: const Row(
                      children: [
                        Text(
                          "Delete All",
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          CupertinoIcons.delete_solid,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                ],
              ),
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: searchNotifire,
                  builder: (context, searchedText, child) {
                    return TaskList(
                        // box: box,
                        searchTextEditingController:
                            searchTextEditingController);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  List<T> sortedBy<T>(List<T> items, bool Function(T a, T b) cond) {
    var sorted_items = items;
    T kepper;
    for (var i = 0; i < sorted_items.length; i++) {
      for (var j = i + 1; j < sorted_items.length; j++) {
        if (cond(sorted_items[i], sorted_items[j])) {
          kepper = sorted_items[i];
          sorted_items[i] = sorted_items[j];
          sorted_items[j] = kepper;
        }
      }
    }
    return sorted_items;
  }
}

class TaskList extends StatefulWidget {
  TaskList({
    super.key,
    // required this.box,
    required this.searchTextEditingController,
  });

  // final Box<Task> box;
  final TextEditingController searchTextEditingController;
  List<double> selectedTasksId = [];
  var isOnCheckMode = false;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController =
        PrimaryScrollController.of(context) ?? ScrollController();
    final repository = Provider.of<Repository<Task>>(context);

    return FutureBuilder(
      future: repository.getAll(
          searchKeyword: widget.searchTextEditingController.text),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data!;
          items.sort(
            (a, b) => a.id.compareTo(b.id),
          );
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: items.length + 1,
            itemBuilder: (context, mineIndex) {
              int index = mineIndex - 1;
              if (index == -1) {
                if (widget.isOnCheckMode) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          elevation: 0,
                          textColor: secondaryTextColor,
                          color: const Color(0xffEAEFF5),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Delete All Selected",
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                CupertinoIcons.delete_solid,
                                size: 18,
                              ),
                            ],
                          ),
                          onPressed: () {
                            for (double id in widget.selectedTasksId) {
                              repository.deleteById(id);
                              // box.values
                              //     .where((element) => widget.selectedTasksId
                              //         .contains(element.id))
                              //     .forEach((element) {
                              //   element.delete();
                              // });
                            }
                            setState(() {
                              widget.isOnCheckMode = !widget.isOnCheckMode;
                              widget.selectedTasksId.clear();
                            });
                          },
                        ),
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              }
              final task = items[index];

              // final task = box.values
              //     .firstWhere((element) => element.name.contains("h"));

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MyTaskKart(
                  width: double.infinity,
                  priority: Priority.high,
                  isChecked: index % 2 == 0,
                  borderRadius: 8,
                  task: task,
                  searchedText:
                      widget.searchTextEditingController.text.isNotEmpty
                          ? widget.searchTextEditingController.text
                          : "",
                  onLongPress: () {
                    setState(() {
                      if (!widget.selectedTasksId.contains(task.id)) {
                        widget.selectedTasksId.add(task.id);
                      } else {
                        widget.selectedTasksId.remove(task.id);
                      }
                      widget.isOnCheckMode = widget.selectedTasksId.isNotEmpty;
                    });
                  },
                  onTab: () {
                    setState(() {
                      if (widget.isOnCheckMode) {
                        if (widget.selectedTasksId.contains(task.id)) {
                          widget.selectedTasksId.remove(task.id);
                          if (widget.selectedTasksId.isEmpty) {
                            widget.isOnCheckMode = !widget.isOnCheckMode;
                          }
                        } else {
                          widget.selectedTasksId.add(task.id);
                        }
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return EditTaskPage(task: task);
                            },
                          ),
                        );
                      }
                    });
                  },
                  isOnCheckMode: widget.isOnCheckMode,
                  selectedTasksId: widget.selectedTasksId,
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text(widget.searchTextEditingController.text.isEmpty
                ? "Tasks Is Empthy"
                : "cant find task with name \"${widget.searchTextEditingController.text}\""),
          );
        }
      },
    );

    // if (widget.searchTextEditingController.text.isNotEmpty) {
    //   items = box.values
    //       .where((task) => task.name
    //           .toLowerCase()
    //           .contains(widget.searchTextEditingController.text.toLowerCase()))
    //       .toList();
    //   items.sort(
    //     (a, b) => a.id.compareTo(b.id),
    //   );
    // items = sortedBy(
    //   items,
    //   (a, b) => a.id > b.id,
    // );
    // } else {
    //   items = box.values.toList();
    //   items.sort(
    //     (a, b) => a.id.compareTo(b.id),
    //   );
    // items = sortedBy(
    //   items,
    //   (a, b) => a.name.length < b.name.length,
    // );
    // }

    // return items.isNotEmpty
    //     ? CustomScrollView(
    //         controller: _scrollController,
    //         slivers: [
    //           ReorderableSliverList(
    //             delegate: ReorderableSliverChildBuilderDelegate(
    //                 (context, mineIndex) {
    //               int index = mineIndex - 1;
    //               if (index == -1) {
    //                 if (widget.isOnCheckMode) {
    //                   return Row(
    //                     children: [
    //                       Expanded(
    //                         flex: 1,
    //                         child: MaterialButton(
    //                           child: Text("delete all selected"),
    //                           onPressed: () {
    //                             for (double id in widget.selectedTasksId) {
    //                               box.values
    //                                   .where((element) => widget
    //                                       .selectedTasksId
    //                                       .contains(element.id))
    //                                   .forEach((element) {
    //                                 element.delete();
    //                               });
    //                               setState(() {
    //                                 widget.isOnCheckMode =
    //                                     !widget.isOnCheckMode;
    //                               });
    //                             }
    //                           },
    //                         ),
    //                       )
    //                     ],
    //                   );
    //                 } else {
    //                   return Container();
    //                 }
    //               }
    //               final task = items[index];

    //               // final task = box.values
    //               //     .firstWhere((element) => element.name.contains("h"));

    //               return Padding(
    //                 padding: const EdgeInsets.only(bottom: 10),
    //                 child: MyTaskKart(
    //                   width: double.infinity,
    //                   priority: Priority.high,
    //                   isChecked: index % 2 == 0,
    //                   borderRadius: 8,
    //                   task: task,
    //                   searchedText:
    //                       widget.searchTextEditingController.text.isNotEmpty
    //                           ? widget.searchTextEditingController.text
    //                           : "",
    //                   onLongPress: () {
    //                     setState(() {
    //                       if (!widget.selectedTasksId.contains(task.id)) {
    //                         widget.selectedTasksId.add(task.id);
    //                       } else {
    //                         widget.selectedTasksId.remove(task.id);
    //                       }
    //                       widget.isOnCheckMode =
    //                           widget.selectedTasksId.isNotEmpty;
    //                     });
    //                   },
    //                   onTab: () {
    //                     setState(() {
    //                       if (widget.isOnCheckMode) {
    //                         if (widget.selectedTasksId.contains(task.id)) {
    //                           widget.selectedTasksId.remove(task.id);
    //                           if (widget.selectedTasksId.isEmpty) {
    //                             widget.isOnCheckMode =
    //                                 !widget.isOnCheckMode;
    //                           }
    //                         } else {
    //                           widget.selectedTasksId.add(task.id);
    //                         }
    //                       } else {
    //                         Navigator.of(context).push(
    //                           MaterialPageRoute(
    //                             builder: (context) {
    //                               return EditTaskPage(task: task);
    //                             },
    //                           ),
    //                         );
    //                       }
    //                     });
    //                   },
    //                   isOnCheckMode: widget.isOnCheckMode,
    //                   selectedTasksId: widget.selectedTasksId,
    //                 ),
    //               );
    //             }, childCount: items.length),
    //             onReorder: (oldIndex, newIndex) {
    //               onReorder(oldIndex, newIndex, box);
    //             },
    //           )
    //         ],
    //       )
    //     : Center(
    //         child: Text("Tasks Is Empthy"),
    //       );

    // List<DragAndDropItem> dragAndDropItems = List.generate(
    //   items.length,
    //   (index) {
    //     // // // int index = mineIndex - 1;
    //     // // //         if (index == -1) {
    //     // // //           if (widget.isOnCheckMode) {
    //     // // //             return Row(
    //     // // //               children: [
    //     // // //                 Expanded(
    //     // // //                   flex: 1,
    //     // // //                   child: MaterialButton(
    //     // // //                     child: Text("delete all selected"),
    //     // // //                     onPressed: () {
    //     // // //                       for (double id in widget.selectedTasksId) {
    //     // // //                         box.values
    //     // // //                             .where((element) => widget.selectedTasksId
    //     // // //                                 .contains(element.id))
    //     // // //                             .forEach((element) {
    //     // // //                           element.delete();
    //     // // //                         });
    //     // // //                         setState(() {
    //     // // //                           widget.isOnCheckMode =
    //     // // //                               !widget.isOnCheckMode;
    //     // // //                         });
    //     // // //                       }
    //     // // //                     },
    //     // // //                   ),
    //     // // //                 )
    //     // // //               ],
    //     // // //             );
    //     // // //           } else {
    //     // // //             return Container();
    //     // // //           }
    //     // // //         }
    //     final task = items[index];

    //     // final task = box.values
    //     //     .firstWhere((element) => element.name.contains("h"));

    //     return DragAndDropItem(
    //       child: Padding(
    //         padding: const EdgeInsets.only(bottom: 10),
    //         child: MyTaskKart(
    //           width: double.infinity,
    //           priority: Priority.high,
    //           isChecked: index % 2 == 0,
    //           borderRadius: 8,
    //           task: task,
    //           searchedText:
    //               widget.searchTextEditingController.text.isNotEmpty
    //                   ? widget.searchTextEditingController.text
    //                   : "",
    //           onLongPress: () {
    //             setState(() {
    //               if (!widget.selectedTasksId.contains(task.id)) {
    //                 widget.selectedTasksId.add(task.id);
    //               } else {
    //                 widget.selectedTasksId.remove(task.id);
    //               }
    //               widget.isOnCheckMode = widget.selectedTasksId.isNotEmpty;
    //             });
    //           },
    //           onTab: () {
    //             setState(() {
    //               if (widget.isOnCheckMode) {
    //                 if (widget.selectedTasksId.contains(task.id)) {
    //                   widget.selectedTasksId.remove(task.id);
    //                   if (widget.selectedTasksId.isEmpty) {
    //                     widget.isOnCheckMode = !widget.isOnCheckMode;
    //                   }
    //                 } else {
    //                   widget.selectedTasksId.add(task.id);
    //                 }
    //               } else {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(
    //                     builder: (context) {
    //                       return EditTaskPage(task: task);
    //                     },
    //                   ),
    //                 );
    //               }
    //             });
    //           },
    //           isOnCheckMode: widget.isOnCheckMode,
    //           selectedTasksId: widget.selectedTasksId,
    //         ),
    //       ),
    //     );
    //   },
    // );
    // return DragAndDropLists(
    //   children: [
    //     DragAndDropList(
    //       children: dragAndDropItems,
    //     ),
    //   ],
    //   onItemReorder:
    //       (oldItemIndex, oldListIndex, newItemIndex, newListIndex) {},
    //   onListReorder: (oldListIndex, newListIndex) {},
    // );
  }

  void onReorder(int oldIndex, int newIndex, Box<Task> box) {
    final Task selectedTask = box.values.toList()[oldIndex];
    final Task firstTask = box.values.first;
    if (newIndex != oldIndex && box.values.length > 1) {
      if (newIndex == box.values.length - 1) {
        selectedTask.id = (31 * box.values.last.id + 1) / 32;
        selectedTask.save();
      } else if (newIndex == 0) {
        firstTask.id = box.values.toList()[1].id / 2;
        selectedTask.id = 0;
        firstTask.save();
        selectedTask.save();
      } else {
        selectedTask.id = (box.values.toList()[newIndex - 1].id +
                box.values.toList()[newIndex + 1].id) /
            2;
        selectedTask.save();
      }
    }
  }
}

class MyTaskKart extends StatefulWidget {
  MyTaskKart({
    super.key,
    required this.width,
    required this.priority,
    required this.isChecked,
    required this.borderRadius,
    required this.task,
    required this.searchedText,
    required this.onLongPress,
    required this.onTab,
    required this.isOnCheckMode,
    required this.selectedTasksId,
  });
  final double width;
  final Priority priority;
  final bool isChecked;
  final double borderRadius;
  final Task task;
  final String searchedText;
  final bool isOnCheckMode;
  final List<double> selectedTasksId;

  Function() onLongPress;
  Function() onTab;

  @override
  State<MyTaskKart> createState() => _MyTaskKartState();
}

class _MyTaskKartState extends State<MyTaskKart> {
  @override
  Widget build(BuildContext context) {
    final TextStyle theme = Theme.of(context).textTheme.bodyMedium!.copyWith(
        decorationStyle: TextDecorationStyle.solid,
        decoration: widget.task.isCompleted
            ? TextDecoration.lineThrough
            : TextDecoration.none);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Slidable(
          closeOnScroll: true,
          enabled: !widget.isOnCheckMode,
          direction: Axis.horizontal,
          dragStartBehavior: DragStartBehavior.down,
          startActionPane: ActionPane(
              motion: BehindMotion(),
              dragDismissible: true,
              dismissible: DismissiblePane(
                onDismissed: () {},
              ),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(0),
                  backgroundColor: Colors.red,
                  foregroundColor: Color.fromARGB(255, 248, 224, 223),
                  icon: Icons.delete,
                  spacing: 0,
                  flex: 1,
                  autoClose: true,
                  onPressed: (context) {
                    widget.task.delete();
                  },
                ),
              ]),
          child: InkWell(
            onLongPress: widget.onLongPress,
            onTap: widget.onTab,
            child: Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.only(top: 0, bottom: 0, right: 0),
              width: widget.width,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(widget.borderRadius),
                  bottomRight: Radius.circular(widget.borderRadius),
                ),
                color: widget.selectedTasksId.contains(widget.task.id)
                    ? Color.fromARGB(255, 245, 255, 246)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.05),
                  )
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.task.isCompleted = !widget.task.isCompleted;
                        widget.task.save();
                      });
                    },
                    child: MyCheckBox(
                      value: widget.task.isCompleted,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SearchAllText(
                          text: "${widget.task.name}", // ${widget.task.id}",
                          serchedText: widget.searchedText,
                          anyCaseSearched: true,
                          textStyle: theme,
                          searchStyle: theme.apply(
                              color: Colors.blue,
                              fontSizeFactor: 1.05,
                              fontWeightDelta: 2)),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight,
                    width: 8,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //     topRight: Radius.circular(this.widget.borderRadius),
                      //     bottomRight: Radius.circular(this.widget.borderRadius)),
                      color: colorOfPriority[widget.task.priority],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color color() {
    switch (widget.task.priority) {
      case Priority.high:
        return Color.fromARGB(255, 83, 69, 206);
      case Priority.low:
        return const Color.fromARGB(255, 243, 187, 33);
      default:
        return Colors.white.withOpacity(0);
    }
  }
}

const Map<Priority, Color> colorOfPriority = {
  Priority.high: Color.fromARGB(255, 69, 43, 184),
  Priority.normal: Color.fromARGB(255, 231, 143, 29),
  Priority.low: Color.fromARGB(255, 13, 167, 214),
};

class MyCheckBox extends StatelessWidget {
  const MyCheckBox(
      {super.key,
      required this.value,
      required this.onChanged,
      this.size = 18,
      this.color = primaryColor,
      this.isColorBackground = false});
  final bool value;
  final Color color;
  final Function(bool value) onChanged;
  final double size;
  final bool isColorBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: value
            ? color
            : isColorBackground
                ? color
                : Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(50),
        border: value
            ? null
            : isColorBackground
                ? null
                : Border.all(
                    color: Theme.of(context).colorScheme.background, width: 3),
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: value
              ? Theme.of(context).colorScheme.onPrimary
              : isColorBackground
                  ? color
                  : Theme.of(context).colorScheme.onPrimary,
          size: size / 1.5,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EditTaskPage extends StatefulWidget {
  EditTaskPage({super.key, required this.task});
  final Task task;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late final TextEditingController _controller = TextEditingController(
      text: widget.task.isInBox ? widget.task.name : null);

  late Priority priority =
      widget.task.isInBox ? widget.task.priority : Priority.normal;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,
        title: const Text("Edit Task"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final repository = Provider.of<Repository<Task>>(context);
            widget.task.name = _controller.text;
            widget.task.priority = priority;
            if (widget.task.isInBox) {
              // final Box<Task> box = Hive.box(taskBoxName);
              repository.hsValue().then((boxHasValue) {
                if (!boxHasValue) {
                  widget.task.id = 0;
                } else {
                  repository.getAll().then((list) {
                    list.sort(
                      (a, b) => a.id.compareTo(b.id),
                    );

                    widget.task.id =
                        (31 * list.last.id + 1) / 32; //box.values.last.id
                  });
                }
                // box.add(widget.task);
              });
            }

            repository.createOrUpdate(widget.task);
            // widget.task.save();
            Navigator.of(context).pop();
          },
          label: const Row(
            children: [
              Text("Save Changes"),
              Icon(
                CupertinoIcons.check_mark,
                size: 16,
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        priority = Priority.high;
                      });
                    },
                    child: PriorityBox(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      text: Text(
                        "High",
                        style: themeData.textTheme.headlineSmall!
                            .apply(fontSizeFactor: 0.7),
                      ),
                      color: colorOfPriority[Priority.high],
                      value: priority == Priority.high,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        priority = Priority.normal;
                      });
                    },
                    child: PriorityBox(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      text: Text(
                        "Normal",
                        style: themeData.textTheme.headlineSmall!
                            .apply(fontSizeFactor: 0.7),
                      ),
                      color: colorOfPriority[Priority.normal],
                      value: priority == Priority.normal,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        priority = Priority.low;
                      });
                    },
                    child: PriorityBox(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      text: Text(
                        "Low",
                        style: themeData.textTheme.headlineSmall!
                            .apply(fontSizeFactor: 0.7),
                      ),
                      color: colorOfPriority[Priority.low],
                      value: priority == Priority.low,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: false,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          priority = Priority.high;
                        });
                      },
                      child: PriorityBox(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        text: Text(
                          "High",
                          style: themeData.textTheme.headlineSmall!
                              .apply(fontSizeFactor: 0.7),
                        ),
                        color: colorOfPriority[Priority.high],
                        value: priority == Priority.high,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          priority = Priority.normal;
                        });
                      },
                      child: PriorityBox(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        text: Text(
                          "Normal",
                          style: themeData.textTheme.headlineSmall!
                              .apply(fontSizeFactor: 0.7),
                        ),
                        color: colorOfPriority[Priority.normal],
                        value: priority == Priority.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          priority = Priority.low;
                        });
                      },
                      child: PriorityBox(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        text: Text(
                          "Low",
                          style: themeData.textTheme.headlineSmall!
                              .apply(fontSizeFactor: 0.7),
                        ),
                        color: colorOfPriority[Priority.low],
                        value: priority == Priority.low,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
                controller: _controller,
                maxLength: 100,
                maxLines: 1,
                decoration: const InputDecoration(
                    label: Text("Add a task for today..."))),
          ],
        ),
      ),
    );
  }
}

//****************************************************************** */
class SearchAllText extends StatelessWidget {
  const SearchAllText(
      {super.key,
      required this.text,
      required this.serchedText,
      required this.textStyle,
      required this.searchStyle,
      this.anyCaseSearched = true});

  final String text;
  final String serchedText;
  final TextStyle textStyle;
  final TextStyle searchStyle;
  final bool anyCaseSearched;

  @override
  RichText build(BuildContext context) {
    return RichText(
      text: search(text),
      // overflow: TextOverflow.ellipsis,//when wanted to do not show all of text an for ex: more...
    );
  }

  TextSpan search(String txt) {
    final String lowerText = anyCaseSearched ? txt.toLowerCase() : txt;
    final String lowerSearch =
        anyCaseSearched ? serchedText.toLowerCase() : serchedText;
    if (lowerSearch.length > lowerText.length ||
        lowerText == "" ||
        lowerSearch == "") {
      return TextSpan(
        text: txt,
        style: textStyle,
      );
    }
    if (lowerText.contains(lowerSearch)) {
      if (lowerSearch.length == lowerText.length) {
        //finded is in the same text ***
        return TextSpan(text: txt, style: searchStyle);
      } else if (lowerText.indexOf(lowerSearch) == 0) {
        //find in start of text ***(......)
        return TextSpan(children: [
          TextSpan(
              text: txt.substring(0, lowerSearch.length), style: searchStyle),
          search(txt.substring(lowerSearch.length))
        ]);
      } else if (lowerText.indexOf(lowerSearch) ==
          lowerText.length - lowerSearch.length) {
        //find in end of text ......***
        return TextSpan(children: [
          TextSpan(
            text: txt.substring(0, lowerText.length - lowerSearch.length),
            style: textStyle,
          ),
          TextSpan(
            text: txt.substring(lowerText.length - lowerSearch.length),
            style: searchStyle,
          )
        ]);
      } else {
        //find in betwin of text ...***(...)
        return TextSpan(children: [
          TextSpan(
            text: txt.substring(0, lowerText.indexOf(lowerSearch)),
            style: textStyle,
          ),
          TextSpan(
            text: txt.substring(lowerText.indexOf(lowerSearch),
                lowerSearch.length + lowerText.indexOf(lowerSearch)),
            style: searchStyle,
          ),
          search(txt
              .substring(lowerSearch.length + lowerText.indexOf(lowerSearch)))
        ]);
      }
    } else {
      return TextSpan(
        text: txt,
        style: textStyle,
      );
    }
  }
}

class PriorityBox extends StatelessWidget {
  const PriorityBox(
      {super.key,
      required this.text,
      required this.color,
      this.padding = EdgeInsets.zero,
      required this.value});
  final Text text;
  final Color? color;
  final bool value;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.2)),
            ]),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 1,
            )),
            text,
            MyCheckBox(
              isColorBackground: true,
              color: color!,
              value: value,
              size: 15,
              onChanged: (value) {},
            )
          ],
        ));
  }
}
