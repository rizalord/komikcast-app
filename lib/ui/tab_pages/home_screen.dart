import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ComicSlider(width: width),
          ],
        ),
      ),
    );
  }
}

class ComicSlider extends StatelessWidget {
  const ComicSlider({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: width * .55,
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: width * .4,
            height: width * .55,
            color: Colors.blue,
            child: Stack(
              children: [
                Image.network(
                  'https://komikcast.com/wp-content/uploads/2019/08/394643123213da-e1565782699221.jpg',
                  fit: BoxFit.cover,
                  width: width * .4,
                  height: width * .55,
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: ComicTypeCard(text: 'Manhua'),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: width * .4,
            height: width * .55,
            color: Colors.blue,
            child: Stack(
              children: [
                Image.network(
                  'https://komikcast.com/wp-content/uploads/2017/08/180-1.jpg',
                  fit: BoxFit.cover,
                  width: width * .4,
                  height: width * .55,
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: ComicTypeCard(text: 'Manga'),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: width * .4,
            height: width * .55,
            color: Colors.blue,
            child: Stack(
              children: [
                Image.network(
                  'https://komikcast.com/wp-content/uploads/2020/02/adlasofalnoe.jpg',
                  fit: BoxFit.cover,
                  width: width * .4,
                  height: width * .55,
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: ComicTypeCard(text: 'Manhwa'),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: width * .4,
            height: width * .55,
            color: Colors.blue,
            child: Stack(
              children: [
                Image.network(
                  'https://komikcast.com/wp-content/uploads/2020/06/IMG_20200624_174041-e1592995348216.jpg',
                  fit: BoxFit.cover,
                  width: width * .4,
                  height: width * .55,
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: ComicTypeCard(text: 'Manhwa'),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: width * .4,
            height: width * .55,
            color: Colors.blue,
            child: Stack(
              children: [
                Image.network(
                  'https://komikcast.com/wp-content/uploads/2020/06/22fsg1sa5w3rt1agv15-e1591782065864.jpeg',
                  fit: BoxFit.cover,
                  width: width * .4,
                  height: width * .55,
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: ComicTypeCard(text: 'Manga'),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: width * .4,
            height: width * .55,
            color: Colors.blue,
            child: Stack(
              children: [
                Image.network(
                  'https://komikcast.com/wp-content/uploads/2020/06/4fd2saf2725wtv1-e1592991232714.jpg',
                  fit: BoxFit.cover,
                  width: width * .4,
                  height: width * .55,
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: ComicTypeCard(text: 'Manga'),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: width * .4,
            height: width * .55,
            color: Colors.blue,
            child: Stack(
              children: [
                Image.network(
                  'https://komikcast.com/wp-content/uploads/2019/01/binetsu.jpg',
                  fit: BoxFit.cover,
                  width: width * .4,
                  height: width * .55,
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: ComicTypeCard(text: 'Manga'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ComicTypeCard extends StatelessWidget {
  const ComicTypeCard({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: text.toLowerCase() == 'manhua'
            ? Colors.green
            : text.toLowerCase() == 'manhwa' ? Colors.brown : Colors.blue[400],
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.center,
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.heebo(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
