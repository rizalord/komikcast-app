import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komikcast/components/appbar/download_appbar.dart';
import 'package:komikcast/components/appbar/favorite_appbar.dart';
import 'package:komikcast/components/appbar/home_appbar.dart';
import 'package:komikcast/components/appbar/search_appbar.dart';
import 'package:komikcast/ui/tab_pages/home_screen.dart';
import 'package:komikcast/ui/tab_pages/search_screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pages = [
    HomeTabPage(),
    SearchTabPage(),
    HomeTabPage(),
    HomeTabPage(),
  ];

  final _appBars = [
    HomeAppBar(),
    SearchingAppBar(),
    FavoriteAppBar(),
    DownloadAppBar(),
  ];

  int _selectedIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
  }

  void changePage(index) => setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[_selectedIndex],
      drawer: Drawer(
        child: Column(
          // padding: EdgeInsets.zero,
          mainAxisSize: MainAxisSize.max,
          children: [
            DrawerHeader(
              child: Image.asset('assets/images/watermark.png'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.commentAlt,
                color: Colors.blue,
              ),
              title: Text('Masukan'),
              onTap: () {
                Modular.to.pop(context);
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
              title: Text('Sukai kami'),
              onTap: () {
                Modular.to.pop(context);
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.share,
                color: Colors.blue,
              ),
              title: Text('Beri tahu teman anda'),
              onTap: () {
                Modular.to.pop(context);
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.cog,
                color: Colors.blue,
              ),
              title: Text('Pengaturan'),
              onTap: () {
                Modular.to.pop(context);
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Theme.of(context).textSelectionHandleColor.withOpacity(.08)
                      ),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 54.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.lightbulb,
                            color: Theme.of(context).textSelectionHandleColor.withOpacity(.4)
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.chrome,
                            color: Theme.of(context).textSelectionHandleColor.withOpacity(.4)
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        children: _pages,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: changePage,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorite'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.file_download),
            title: Text('Downloads'),
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
