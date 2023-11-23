import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//start ms-settings:developers
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class MyAppThemeConfig {
  final Color seedColor;
  final Color dividerThemeColor;
  final Color fillColor;
  final Color primaryColor;
  final Color scaffoldBackgroundColor;
  final Color backgroundColor;
  final Color textThemeColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : seedColor = Colors.deepPurple,
        brightness = Brightness.dark,
        dividerThemeColor = Color.fromARGB(100, 255, 255, 255),
        fillColor = Color.fromARGB(20, 255, 255, 255),
        primaryColor = Colors.pink.shade400,
        scaffoldBackgroundColor = Color.fromARGB(255, 30, 30, 30),
        backgroundColor = Colors.black,
        textThemeColor = Color.fromARGB(150, 255, 255, 255);

  MyAppThemeConfig.light()
      : seedColor = Colors.deepPurple,
        brightness = Brightness.light,
        dividerThemeColor = Color.fromARGB(100, 255, 255, 255),
        fillColor = Color.fromARGB(19, 255, 255, 255),
        primaryColor = Colors.pink.shade400,
        scaffoldBackgroundColor = Color.fromARGB(255, 255, 255, 255),
        backgroundColor = const Color.fromARGB(255, 255, 255, 255),
        textThemeColor = Color.fromARGB(149, 0, 0, 0);

  ThemeData getTeme() {
    return ThemeData(
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
      colorScheme:
          ColorScheme.fromSeed(seedColor: seedColor, brightness: brightness),

      dividerTheme: DividerThemeData(
          color: dividerThemeColor, indent: 4, endIndent: 4, thickness: 0.3),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: fillColor,
      ),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
      ),
      useMaterial3: true,
      //brightness: Brightness.dark,
      textTheme: GoogleFonts.latoTextTheme(
        TextTheme(
            bodyMedium: TextStyle(fontSize: 15),
            bodyLarge:
                TextStyle(fontSize: 12, height: 1.5, color: textThemeColor)),
      ),
    );
  }
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;
  Locale _locale = Locale("en");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   Locale('en'), // English
      //   Locale('fa'), // farsi
      // ],
      locale: _locale,
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTeme()
          : MyAppThemeConfig.light().getTeme(),
      home: MyHomePage(
        themeModeFunction: () {
          setState(() {
            themeMode =
                themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
          });
        },
        selectedLanguege: (_Language ln) {
          setState(() {
            _locale = ln == _Language.en ? Locale("en") : Locale("fa");
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function() themeModeFunction;
  final Function(_Language ln) selectedLanguege;

  const MyHomePage(
      {super.key,
      required this.themeModeFunction,
      required this.selectedLanguege});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var skills = [];
  void addOrRemoveSkills(skillType skill) => setState(() {
        skills.contains(skill) ? skills.remove(skill) : skills.add(skill);
      });
  int iconIndex = 0;
  var icons = [
    Icon(
      CupertinoIcons.suit_heart,
      color: Colors.pink.shade400,
      size: 25,
    ),
    Icon(
      CupertinoIcons.suit_heart_fill,
      color: Colors.pink.shade400,
      size: 25,
    ),
  ];
  _Language language = _Language.en;
  void SetLanguageState(_Language lan) {
    widget.selectedLanguege(lan);
    setState(() {
      language = lan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleBar,
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: Icon(CupertinoIcons.chat_bubble),
          ),
          InkWell(
              onTap: widget.themeModeFunction,
              child: Icon(CupertinoIcons.ellipsis_vertical)),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.asset(
                      "assets/images/sexy.jfif",
                      width: 66,
                      height: 66,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.userName, //UserName
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Text(AppLocalizations.of(context)!
                            .userTitle), //userTitle
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              size: 18,
                              CupertinoIcons.map_pin_ellipse,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .userLocation, //userLocation
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      setState(() {
                        iconIndex = iconIndex == 0 ? 1 : 0;
                      });
                    },
                    child: icons[iconIndex],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: Text(
                AppLocalizations.of(context)!.userText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!
                      .selectedLanguage), //selected Language
                  CupertinoSlidingSegmentedControl<_Language>(
                      groupValue: language,
                      children: {
                        _Language.en:
                            Text(AppLocalizations.of(context)!.enLanguage),
                        _Language.fa:
                            Text(AppLocalizations.of(context)!.faLanguage),
                      },
                      onValueChanged: (value) {
                        value != null ? SetLanguageState(value) : null;
                      })
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(AppLocalizations.of(context)!.skills,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(
                  width: 2,
                ),
                const Icon(
                  CupertinoIcons.chevron_down,
                  size: 12,
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      direction: Axis.horizontal,
                      children: [
                        // Skills Aray -----------
                        Skill(
                          isActive: skills.contains(skillType.csharp),
                          skill: skillType.csharp,
                          onTap: () {
                            addOrRemoveSkills(skillType.csharp);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langcsharp,
                          icon: CupertinoIcons.cube_box,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.php),
                          skill: skillType.php,
                          onTap: () {
                            addOrRemoveSkills(skillType.php);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langphp,
                          icon: CupertinoIcons.list_bullet_below_rectangle,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.python),
                          skill: skillType.python,
                          onTap: () {
                            addOrRemoveSkills(skillType.python);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langpython,
                          icon: CupertinoIcons.archivebox,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.flutter),
                          skill: skillType.flutter,
                          onTap: () {
                            addOrRemoveSkills(skillType.flutter);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langflutter,
                          icon: CupertinoIcons.layers,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.fortran),
                          skill: skillType.fortran,
                          onTap: () {
                            addOrRemoveSkills(skillType.fortran);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langfortran,
                          icon: CupertinoIcons.keyboard_chevron_compact_down,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.go),
                          skill: skillType.go,
                          onTap: () {
                            addOrRemoveSkills(skillType.go);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langgo,
                          icon: CupertinoIcons.hand_draw,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.sql),
                          skill: skillType.sql,
                          onTap: () {
                            addOrRemoveSkills(skillType.sql);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langsql,
                          icon: CupertinoIcons.light_max,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.html),
                          skill: skillType.html,
                          onTap: () {
                            addOrRemoveSkills(skillType.html);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langHtml,
                          icon: CupertinoIcons.hand_thumbsup,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.css),
                          skill: skillType.css,
                          onTap: () {
                            addOrRemoveSkills(skillType.css);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langCss,
                          icon: CupertinoIcons.clock_solid,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.js),
                          skill: skillType.js,
                          onTap: () {
                            addOrRemoveSkills(skillType.js);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langJs,
                          icon: CupertinoIcons.text_justify,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.django),
                          skill: skillType.django,
                          onTap: () {
                            addOrRemoveSkills(skillType.django);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langDjango,
                          icon: CupertinoIcons.doc_append,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.laravel),
                          skill: skillType.laravel,
                          onTap: () {
                            addOrRemoveSkills(skillType.laravel);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langLaravel,
                          icon: CupertinoIcons.lasso,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.android),
                          skill: skillType.android,
                          onTap: () {
                            addOrRemoveSkills(skillType.android);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langAndroid,
                          icon: CupertinoIcons.arrow_down,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.nextjs),
                          skill: skillType.nextjs,
                          onTap: () {
                            addOrRemoveSkills(skillType.nextjs);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langNextJs,
                          icon: CupertinoIcons.number,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.reactjs),
                          skill: skillType.reactjs,
                          onTap: () {
                            addOrRemoveSkills(skillType.reactjs);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langReactJs,
                          icon: CupertinoIcons.news,
                        ),
                        Skill(
                          isActive: skills.contains(skillType.vuejs),
                          skill: skillType.vuejs,
                          onTap: () {
                            addOrRemoveSkills(skillType.vuejs);
                          },
                          shadowColor: Color.fromARGB(
                              200,
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)),
                          title: AppLocalizations.of(context)!.langVueJs,
                          icon: CupertinoIcons.macwindow,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              endIndent: 8,
              indent: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.singUp,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                        decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.inputName,
                      prefixIcon: Icon(CupertinoIcons.person),
                    )),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                        decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.inputPass,
                      prefixIcon: Icon(CupertinoIcons.lock),
                    )),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 201, 44, 96)),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white60)),
                          onPressed: () {
                            setState(() {
                              this.skills.clear();
                            });
                          },
                          child:
                              Text(AppLocalizations.of(context)!.buttonSave)),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

var icons = [
  CupertinoIcons.ant_circle,
  CupertinoIcons.scribble,
  CupertinoIcons.film,
  CupertinoIcons.question_circle_fill,
  CupertinoIcons.waveform_path_badge_plus,
  CupertinoIcons.hand_draw_fill,
  CupertinoIcons.divide,
  CupertinoIcons.table_badge_more,
  CupertinoIcons.backward,
];

enum skillType {
  csharp,
  php,
  python,
  flutter,
  fortran,
  go,
  sql,
  html,
  css,
  js,
  vuejs,
  reactjs,
  nextjs,
  laravel,
  django,
  android,
  kotlin
}

enum _Language {
  en,
  fa,
}

class Skill extends StatelessWidget {
  final String title;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;
  final skillType skill;
  final dynamic icon;

  const Skill({
    super.key,
    required this.isActive,
    required this.shadowColor,
    required this.title,
    required this.onTap,
    required this.skill,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: isActive ? shadowColor.withAlpha(15) : null,
            borderRadius: BorderRadius.circular(16),
          ),
          width: 110,
          height: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                                color: shadowColor.withOpacity(0.5),
                                blurRadius: 10,
                                blurStyle: BlurStyle.outer),
                          ]
                        : null),
                child: Icon(
                  this.icon,
                  //icons[Random().nextInt(icons.length - 1)],
                  size: 35,
                  color: shadowColor,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 12,
                    color: isActive ? shadowColor.withOpacity(0.8) : null),
              )
            ],
          )),
    );
  }
}
