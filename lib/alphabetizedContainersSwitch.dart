import 'package:flutter/material.dart';
import 'package:scrolltest/data.dart';

class expandingHomeScreenSwitch extends StatelessWidget {
  expandingHomeScreenSwitch({Key key}) : super(key: key);
  bool isSwitched;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Expandable Home Screen'),
        Switch(
            value: isSwitched,
            onChanged: (value) {
              expandableHomeScreen = value;
            })
      ],
    );
  }
}
