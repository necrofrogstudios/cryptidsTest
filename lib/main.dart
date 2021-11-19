import 'package:flutter/material.dart';
import 'drawer.dart';
import 'mainpagebutton.dart';
import 'data.dart';
import 'splash.dart';

void main() {
  for (int i = 0; i < myList.length; i++) {
    myList[i]['isLiked'] = false;
  }
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
  List<Map> newMyList = List.from(myList);

  onItemChanged(String value) {
    setState(() {
      print(value);
      if (value == '') {
        newMyList = myList;
      } else {
        newMyList = [];
        for (int i = 0; i < myList.length; i++) {
          if (myList[i]['title'].toLowerCase().contains(value.toLowerCase())) {
            newMyList.add(myList[i]);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, backgroundColor: Colors.purple, title: appBarTitle, actions: <Widget>[
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
              Image.network('https://i.pinimg.com/originals/1f/1a/2a/1f1a2ad5a16dd38f2ac1568315928f69.jpg'),
              ListView(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: newMyList.map((data) {
                  return Card(child: mainpagebutton(data));
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
