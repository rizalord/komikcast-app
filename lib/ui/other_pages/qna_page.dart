import 'package:flutter/material.dart';

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
                'Komikcast adalah aplikasi untuk membaca komik online bahasa indonesia secara gratis dengan fitur-fitur yang bejibun.',
          ),
          ListItem(
            title: 'Cara menggunakan Komikcast?',
            subtitle: 'Tinggal baca bangsat!',
          ),
          ListItem(
            title: 'Bagaimana cara mendownload manga secara permanen?',
            subtitle:
                'Untuk bisa mendownload manga secara permanen dan tanpa batasan jumlah download, anda perlu membeli versi Pro dari aplikasi ini.',
          ),
          ListItem(
            title: 'Bagaimana cara mengaktifkan dark mode?',
            subtitle:
                'Untuk bisa mengaktifkan dark mode, anda perlu membeli versi Pro dari aplikasi ini.',
          ),
          ListItem(
            title: 'Apakah versi Pro bisa dibagikan ke perangkat lain?',
            subtitle:
                'Versi Pro hanya bisa digunakan untuk satu perangkat saja, ini berguna untuk melindungi aplikasi kami dari program-program berbahaya seperti Lucky Patcher, Game Guardian, dsb.',
          ),
          ListItem(
            title: 'Bagaimana cara kerja versi Pro?',
            subtitle:
                'Ketika anda dialihkan ke halaman pembayaran dan mengisi form yang telah disediakan, anda secara otomatis akan mendapatkan kode aktivasi melalui Email. Setelah anda melakukan aktivasi, server akan menyimpan unique id dari perangkat anda, sehingga ketika anda akan melakukan aktivasi dari perangkat lain akan kami blokir demi keamanan bersama.',
          ),
          ListItem(
            title: 'Apakah versi Pro memiliki durasi?',
            subtitle:
                'Tidak, setelah anda membeli versi Pro anda bebas menggunakan aplikasi beserta fitur pro-nya seumur hidup tanpa batasan apapun.',
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
