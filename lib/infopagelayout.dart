import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'mainpagebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';

class infopagelayout extends StatelessWidget {
  final data;
  infopagelayout(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Text(
              data.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: LikeButton(
                circleColor: CircleColor(start: Colors.pink, end: Colors.red),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Colors.blue,
                  dotSecondaryColor: Colors.red,
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    size: 28,
                    color: data.isLiked ? Colors.red : Colors.grey,
                  );
                },
                onTap: onLikeButtonTapped,
              ),
            ),
          ],
        ),
        Text(
          data.description,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    final prefs = await SharedPreferences.getInstance();
    if (!data.isLiked) {
      isLiked = true;
    } else {
      isLiked = false;
    }
    if (isLiked) {
      favoriteCreatures.add(data);
      data.isLiked = true;
    } else {
      favoriteCreatures.remove(data);
      data.isLiked = false;
    }
    prefs.setBool(data.name + 'fav', isLiked);
    for (int i = 0; i < favoriteCreatures.length; i++) {
      print(favoriteCreatures[i].name);
    }
    return Future<bool>.value(isLiked);
  }
}
