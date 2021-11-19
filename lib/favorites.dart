import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  _FavoritesState createState() => _FavoritesState();
}

List likedCreatures = [];

// Home Screen
class _FavoritesState extends State<Favorites> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Favorites",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            elevation: 10,
            backgroundColor: Colors.purple));
  }
}
