import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komikcast/bloc/theme_bloc.dart';
import 'package:komikcast/components/appbar/download_appbar.dart';
import 'package:komikcast/components/appbar/favorite_appbar.dart';
import 'package:komikcast/components/appbar/home_appbar.dart';
import 'package:komikcast/components/appbar/search_appbar.dart';
import 'package:komikcast/data/pro_data.dart';
import 'package:komikcast/env.dart';
import 'package:komikcast/models/email_feedback.dart';
import 'package:komikcast/ui/tab_pages/download_screen.dart';
import 'package:komikcast/ui/tab_pages/favorite_screen.dart';
import 'package:komikcast/ui/tab_pages/home_screen.dart';
import 'package:komikcast/ui/tab_pages/search_screen.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pages = [
    HomeTabPage(),
    SearchTabPage(),
    FavoriteTabPage(),
    DownloadTabPage(),
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

  void sendFeedback() async {
    await FlutterEmailSender.send(emailModel);
    Modular.to.pop(context);
  }

  void likeFanpage() {
    FlutterWebBrowser.openWebPage(
        url: Env.fanpage, androidToolbarColor: Theme.of(context).primaryColor);
    Modular.to.pop(context);
  }

  void shareFriend() {
    Share.share(
        'Komikcast - Tempatnya Baca Komik Online Bahasa Indonesia ${Env.webpage}',
        subject: 'Download Aplikasi Komikcast Gratis');
    Modular.to.pop(context);
  }

  void navigateToSetting() {
    Modular.to.pop(context);
    Modular.to.pushNamed('/setting');
  }

  void navigateToQna() {
    Modular.to.pop(context);
    Modular.to.pushNamed('/qna');
  }

  void openWebVersion() async {
    const url = 'https://komikcast.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
              onTap: sendFeedback,
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
              title: Text('Sukai kami'),
              onTap: likeFanpage,
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.share,
                color: Colors.blue,
              ),
              title: Text('Beri tahu teman anda'),
              onTap: shareFriend,
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.cog,
                color: Colors.blue,
              ),
              title: Text('Pengaturan'),
              onTap: navigateToSetting,
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.solidQuestionCircle,
                color: Colors.blue,
              ),
              title: Text('Tanya Jawab'),
              onTap: navigateToQna,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1,
                          color: Theme.of(context)
                              .textSelectionHandleColor
                              .withOpacity(.08)),
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
                            Theme.of(context).brightness == Brightness.dark
                                ? FontAwesomeIcons.solidSun
                                : FontAwesomeIcons.sun,
                            color: Theme.of(context)
                                .textSelectionHandleColor
                                .withOpacity(
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 1
                                      : .4,
                                ),
                          ),
                          onPressed: () {
                            if (ProData().isPro() == true) {
                              Modular.get<ThemeBloc>().add(
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ThemeMode.light
                                      : ThemeMode.dark);
                            } else {
                              Modular.to.pushNamed('/pro');
                            }
                          },
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.chrome,
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.4)),
                          onPressed: openWebVersion,
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
