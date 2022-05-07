import 'package:flutter/material.dart';
import 'package:cryptid_chaos/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class expandingHomeScreenSwitch extends StatefulWidget {
  expandingHomeScreenSwitch({Key key}) : super(key: key);

  @override
  State<expandingHomeScreenSwitch> createState() =>
      _expandingHomeScreenSwitchState();
}

class _expandingHomeScreenSwitchState extends State<expandingHomeScreenSwitch> {
  bool isSwitched = expandingHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              (expandingHomeScreen
                  ? 'Expanding Home Screen enabled'
                  : 'Expanding Home Screen disabled'),
              textScaleFactor: 1.2,
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(
                  () {
                    print(value);
                    isSwitched = value;
                    expandingHomeScreen = value;
                    onExpandingSwitch(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void onExpandingSwitch(bool setting) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('expandingHomeScreen', setting);
  }
}
