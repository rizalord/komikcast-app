import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:komikcast/bloc/download_setting_bloc.dart';
import 'package:komikcast/bloc/theme_bloc.dart';
import 'package:komikcast/data/pro_data.dart';

class MainSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sub 0
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                'Tampilan',
                style: GoogleFonts.heebo(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              child: Material(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Pilih Tema'),
                        content: BlocBuilder<ThemeBloc, ThemeMode>(
                          builder: (_, state) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text('Terang'),
                                leading: Radio(
                                  value: state == ThemeMode.light,
                                  groupValue: true,
                                  onChanged: (_) {
                                    Modular.get<ThemeBloc>()
                                        .add(ThemeMode.light);
                                    Hive.box('komikcast').put('theme', 'light');
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text('Gelap'),
                                leading: Radio(
                                  value: state == ThemeMode.dark,
                                  groupValue: true,
                                  onChanged: (_) {
                                    if (ProData().isPro() == false)
                                      Modular.to.pushNamed('/pro');
                                    else {
                                      Modular.get<ThemeBloc>()
                                          .add(ThemeMode.dark);
                                      Hive.box('komikcast')
                                          .put('theme', 'dark');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      barrierDismissible: true,
                    );
                  },
                  child: ListTile(
                    focusColor: Colors.red,
                    leading: Icon(Icons.wb_sunny),
                    title: Text('Tema'),
                  ),
                ),
                color: Colors.transparent,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor
                  : Colors.grey[100],
            ),
            // Sub 1
            Container(
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                'Penyimpanan',
                style: GoogleFonts.heebo(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              child: Material(
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    focusColor: Colors.red,
                    leading: Icon(Icons.save),
                    title: Text('Lokasi Penyimpanan'),
                    subtitle: Text('/storage/emulated/0/komikcast'),
                  ),
                ),
                color: Colors.transparent,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor
                  : Colors.grey[100],
            ),
            Container(
              child: Material(
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: Icon(Icons.timer),
                    title: Text('Expired'),
                    subtitle: Text('Masa berlaku download'),
                    trailing: BlocBuilder<DownloadSettingBloc, bool>(
                      builder: (_, state) => DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text('15 hari'),
                            value: false,
                          ),
                          DropdownMenuItem(
                            child: Text('Permanen'),
                            value: true,
                          ),
                        ],
                        onChanged: (value) {
                          if (ProData().isPro() == false && value == true)
                            Modular.to.pushNamed('/pro');
                          else {
                            Modular.get<DownloadSettingBloc>().add(value);
                            Hive.box('komikcast')
                                .put('is_download_permanent', value);
                          }
                        },
                        value: state,
                      ),
                    ),
                  ),
                ),
                color: Colors.transparent,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor
                  : Colors.grey[100],
            ),
            // Sub 2
            Container(
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                'Dukungan',
                style: GoogleFonts.heebo(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              child: Material(
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "Coming Soon",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Theme.of(context)
                          .textSelectionHandleColor
                          .withOpacity(.7),
                      textColor:
                          Theme.of(context).textSelectionColor.withOpacity(.8),
                      fontSize: 16.0,
                    );
                  },
                  child: ListTile(
                    focusColor: Colors.red,
                    leading: Icon(Icons.bug_report),
                    title: Text('Laporkan bug dan saran'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
                color: Colors.transparent,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor
                  : Colors.grey[100],
            ),
            Container(
              child: Material(
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "Coming Soon",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Theme.of(context)
                          .textSelectionHandleColor
                          .withOpacity(.7),
                      textColor:
                          Theme.of(context).textSelectionColor.withOpacity(.8),
                      fontSize: 16.0,
                    );
                  },
                  child: ListTile(
                    focusColor: Colors.red,
                    leading: Icon(Icons.stars),
                    title: Text('Beri rating'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
                color: Colors.transparent,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor
                  : Colors.grey[100],
            ),
            Container(
              child: Material(
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "Coming Soon",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Theme.of(context)
                          .textSelectionHandleColor
                          .withOpacity(.7),
                      textColor:
                          Theme.of(context).textSelectionColor.withOpacity(.8),
                      fontSize: 16.0,
                    );
                  },
                  child: ListTile(
                    focusColor: Colors.red,
                    leading: Icon(Icons.verified_user),
                    title: Text('Privacy Policy'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
                color: Colors.transparent,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor
                  : Colors.grey[100],
            ),
            // Sub 3
            Container(
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                'Umum',
                style: GoogleFonts.heebo(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              child: Material(
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    focusColor: Colors.red,
                    leading: FaIcon(FontAwesomeIcons.appStore),
                    title: Text('Versi'),
                    subtitle: Text('Komikcast - v1.0.0'),
                  ),
                ),
                color: Colors.transparent,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor
                  : Colors.grey[100],
            ),
            Container(
              child: Material(
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "Coming Soon",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Theme.of(context)
                          .textSelectionHandleColor
                          .withOpacity(.7),
                      textColor:
                          Theme.of(context).textSelectionColor.withOpacity(.8),
                      fontSize: 16.0,
                    );
                  },
                  child: ListTile(
                    focusColor: Colors.red,
                    leading: Icon(Icons.info_outline),
                    title: Text('Tentang Komikcast'),
                  ),
                ),
                color: Colors.transparent,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor
                  : Colors.grey[100],
            ),
          ],
        ),
      ),
    );
  }
}
