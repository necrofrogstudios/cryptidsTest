import 'package:flutter/material.dart';
import 'drawer.dart';
import 'data.dart';
import 'infopagelayout.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ads/ad_helper.dart';

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
  BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  void _scrollToIndex(int index) {
    _itemScrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic);
  }

  void initState() {
    super.initState();
    _createBottomBannerAd();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToIndex(myList.indexOf(data)));
  }

  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

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
                    return infopagelayout(newMyList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? Container(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
    );
  }
}
