import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:komikcast/bloc/download_setting_bloc.dart';
import 'package:komikcast/data/pro_data.dart';

import '../../env.dart';

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
                  subtitle: Text('/storage/emulated/0/' + Env.appName.toLowerCase().trim()),
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
        ],
      ),
    );
  }
}
