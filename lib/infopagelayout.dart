import 'package:flutter/material.dart';

class infopagelayout extends StatelessWidget {
  final data;
  infopagelayout(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          data.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
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
}
