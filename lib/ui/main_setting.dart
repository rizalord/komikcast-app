import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('Terang'),
                              leading: Radio(
                                value: true,
                                groupValue: true,
                                onChanged: (val) {},
                              ),
                            ),
                            ListTile(
                              title: Text('Gelap'),
                              leading: Radio(
                                value: false,
                                groupValue: true,
                                onChanged: (val) {},
                              ),
                            ),
                          ],
                        ),
                        // actions: [
                        //   ListTile(
                        //     title: Text('Terang'),
                        //     leading: Radio(
                        //       value: true,
                        //       groupValue: true,
                        //       onChanged: (val) {},
                        //     ),
                        //   )
                        // ],
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
                    focusColor: Colors.red,
                    leading: Icon(Icons.timer),
                    title: Text('Expired'),
                    subtitle: Text('Masa berlaku download'),
                    trailing: DropdownButton(
                      items: [
                        DropdownMenuItem(child: Text('30 hari')),
                        DropdownMenuItem(child: Text('Permanen')),
                      ],
                      onChanged: (value) {},
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
                  onTap: () {},
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
                  onTap: () {},
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
                  onTap: () {},
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
                  onTap: () {},
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
