import 'package:flutter/material.dart';
import 'drawer.dart';
import 'data.dart';
import 'infopagelayout.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class infopage extends StatefulWidget {
  final data;

  infopage(this.data);
  _infoState createState() => _infoState(data);
}

class _infoState extends State<infopage> {
  TextEditingController _textController = TextEditingController();
  final data;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Cryptids');
  _infoState(this.data);
  final currentScreen = _infoState;

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  void _scrollToIndex(int index) {
    if (index < 1) {
      _itemScrollController.jumpTo(index: index);
    } else {
      _itemScrollController.jumpTo(index: 0);
      _itemScrollController.scrollTo(
          index: index,
          duration: Duration(milliseconds: 800),
          curve: Curves.linear);
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToIndex(data['index']));
  }

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
                child: ScrollablePositionedList.builder(
                  itemScrollController: _itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemCount: newMyList.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      child: infopagelayout(newMyList[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
