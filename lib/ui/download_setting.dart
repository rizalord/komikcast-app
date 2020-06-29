import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Download'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              'Storage',
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
        ],
      ),
    );
  }
}
