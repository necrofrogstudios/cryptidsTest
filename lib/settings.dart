import 'package:flutter/material.dart';
import 'drawer.dart';
import 'main.dart';
import 'package:scrolltest/expandingHomeScreenSwitch.dart';

class MyApp extends StatelessWidget {
  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            title: 'Cryptid',
            theme: ThemeData(primarySwatch: Colors.purple),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: HomeScreen(),
          );
        });
  }
}

class settings extends StatelessWidget {
  final currentScreen = settings;
  settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        elevation: 10,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.wb_sunny
                  : Icons.brightness_2),
              onPressed: () {
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              })
        ],
        actionsIconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      body: Column(
        children: <Widget>[
          expandingHomeScreenSwitch(),
        ],
      ),
      drawer: drawer(currentScreen),
    );
  }
}
