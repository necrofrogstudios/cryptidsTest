import 'package:flutter/material.dart';
import 'drawer.dart';
import 'mainpagebutton.dart';
import 'data.dart';
import 'splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  MobileAds.instance.initialize();
  favoritesSetUp(prefs); //gets favorites from storage
  settingsSetUp(prefs); //gets settings from storage
  prefs.setBool('firstBoot', false);
  runApp(
    MaterialApp(
      title: 'Cryptid Chaos',
      home: new Splash(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
    ),
  );
}

// Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen();
  //insert in brackets if needed: {Key? key}) : super(key: key
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Home Screen
class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textController = TextEditingController();
  Widget appBarTitle = new Text("Cryptid Chaos");
  final currentScreen = HomeScreen;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Cryptid Chaos');
  // Copy Main List into New List.
  List<mythicalCreature> newMyList = List.from(myList);

  onItemChanged(String value) {
    setState(() {
      print(value);
      if (value == '') {
        newMyList = myList;
      } else {
        newMyList = [];
        for (int i = 0; i < myList.length; i++) {
          if (myList[i].name.toLowerCase().contains(value.toLowerCase())) {
            newMyList.add(myList[i]);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: appBarTitle,
          actions: <Widget>[
            IconButton(
              icon: customIcon,
              onPressed: () {
                setState(() {
                  if (this.customIcon.icon == Icons.search) {
                    this.customIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Search Cryptids',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: onItemChanged,
                    );
                  } else {
                    this.customIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("Cryptid Chaos");
                  }
                });
              },
            ),
          ]),
      drawer: drawer(currentScreen),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              Image.network(
                  'https://i.pinimg.com/originals/1f/1a/2a/1f1a2ad5a16dd38f2ac1568315928f69.jpg'),
              mainPageButtonList(newMyList),
            ],
          ),
        ),
      ),
    );
  }
}

void favoritesSetUp(SharedPreferences prefs) {
  bool firstTime = prefs.getBool('firstBoot');
  if (firstTime == null) {
    for (int i = 0; i < myList.length; i++) {
      prefs.setBool(myList[i].name + 'fav', false);
      myList[i].isLiked = false;
    }
  } else {
    for (int i = 0; i < myList.length; i++) {
      if (prefs.getBool(myList[i].name + 'fav') == null) {
        prefs.setBool(myList[i].name + 'fav', false);
      }
      myList[i].isLiked = prefs.getBool(myList[i].name + 'fav');
      if (prefs.getBool(myList[i].name + 'fav')) {
        favoriteCreatures.add(myList[i]);
      }
    }
  }
}

void settingsSetUp(SharedPreferences prefs) {
  bool firstTime = prefs.getBool('firstBoot');
  if (firstTime == null) {
    prefs.setBool('expandingHomeScreen', false);
    expandingHomeScreen = false;
  } else {
    expandingHomeScreen = prefs.getBool('expandingHomeScreen');
  }
}
