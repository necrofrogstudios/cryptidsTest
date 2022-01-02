import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'infopage.dart';
import 'favorites.dart';
import 'data.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mainpagebutton extends StatefulWidget {
  final mythicalCreature data;
  mainpagebutton(this.data);

  @override
  State<mainpagebutton> createState() => _mainpagebuttonState();
}

class _mainpagebuttonState extends State<mainpagebutton> {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FlatButton(
            height: 60.0,
            color: Colors.purple,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => infopage(widget.data)),
              );
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(
                        child: Text(
                          widget.data.name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        child: LikeButton(
                          circleColor:
                              CircleColor(start: Colors.pink, end: Colors.red),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Colors.blue,
                            dotSecondaryColor: Colors.red,
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              size: 28,
                              color: widget.data.isLiked
                                  ? Colors.red
                                  : Colors.grey,
                            );
                          },
                          onTap: onLikeButtonTapped,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    final prefs = await SharedPreferences.getInstance();
    if (!widget.data.isLiked) {
      isLiked = true;
    } else {
      isLiked = false;
    }
    if (isLiked) {
      favoriteCreatures.add(widget.data);
    } else {
      favoriteCreatures.remove(widget.data);
    }
    setState(() {
      widget.data.isLiked = isLiked;
    });
    prefs.setBool(widget.data.name + 'fav', isLiked);
    for (int i = 0; i < favoriteCreatures.length; i++) {
      print(favoriteCreatures[i].name);
    }
    return Future<bool>.value(isLiked);
  }
}
