import 'package:flutter/material.dart';
import 'infopagelayout.dart';
import 'drawer.dart';
import 'data.dart';

class Favorites extends StatefulWidget {
  _FavoritesState createState() => _FavoritesState();
}

// Home Screen
class _FavoritesState extends State<Favorites> {
  TextEditingController _textController = TextEditingController();
  Widget appBarTitle = new Text("Cryptid Chaos");
  final currentScreen = Favorites;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Cryptid Chaos');
  List<mythicalCreature> newFavoriteCreatures = List.from(favoriteCreatures);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
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
                    ),
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('Cryptid Chaos');
                }
              });
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      drawer: drawer(currentScreen),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: newFavoriteCreatures.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return infopagelayout(newFavoriteCreatures[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onItemChanged(String value) {
    setState(() {
      print(value);
      if (value == '') {
        newFavoriteCreatures = favoriteCreatures;
      } else {
        newFavoriteCreatures = [];
        for (int i = 0; i < favoriteCreatures.length; i++) {
          if (favoriteCreatures[i].name.toLowerCase().contains(value.toLowerCase())) {
            newFavoriteCreatures.add(favoriteCreatures[i]);
          }
        }
      }
    });
  }
}
