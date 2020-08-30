import 'package:flutter/material.dart';
import 'package:komikcast/env.dart';

class QnAPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tanya Jawab'),
      ),
      body: ListView(
        children: [
          ListItem(
            title: 'Mengapa saya perlu aplikasi ini?',
            subtitle:
                Env.appName + ' adalah aplikasi untuk membaca komik online bahasa indonesia secara gratis dengan banyaknya fitur yang disediakan.',
          ),
          ListItem(
            title: 'Cara membaca di ${Env.appName}?',
            subtitle: 'Anda bisa membaca melalui website asli ' + Env.appName + ' (' + Env.webpage + ') atau bisa langsung membaca melalui aplikasi ini.',
          ),
          ListItem(
            title: 'Apakah ada batasan dalam mendownload manga?',
            subtitle:
                'Selama penyimpanan di perangkat anda belum penuh, anda bebas mendownload manga tanpa batasan download.',
          ),
          ListItem(
            title: 'Bagaimana cara mengaktifkan dark mode?',
            subtitle:
                'Untuk bisa mengaktifkan dark mode, anda bisa buka tab setting atau bisa langsung tekan tombol (Matahari) di bagian Navigation Drawer/Sidebar.',
          ),
          ListItem(
            title: 'Apakah ada harga untuk menggunakan aplikasi ini?',
            subtitle:
                'Tidak, aplikasi kami 100% gratis untuk semua kalangan.',
          ),
          ListItem(
            title: 'Bagaimana cara aplikasi ini biar tetap hidup?',
            subtitle:
                'Aplikasi ${Env.appName} bisa tetap hidup dengan adanya iklan dan donasi dari teman-teman semua.',
          ),
          ListItem(
            title: 'Bagaimana cara kita donasi?',
            subtitle:
                'Anda bisa donasi ke kami melalui saweria (' + Env.donateUrl +'). Berapun donasi teman-teman kami akan sangat berterimakasih atas hal itu.',
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.info),
      title: Text(title),
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .2,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.75,
                    color: Theme.of(context)
                        .textSelectionHandleColor
                        .withOpacity(.5),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.0)
      ],
    );
  }
}
