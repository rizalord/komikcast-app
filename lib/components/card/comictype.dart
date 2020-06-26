
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TYPE OF COMIC CARD
class ComicTypeCard extends StatelessWidget {
  const ComicTypeCard({
    Key key,
    this.text,
    this.mini = false
  }) : super(key: key);

  final String text;
  final bool mini;

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
          fontSize: mini == false ? 10 : 7,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
