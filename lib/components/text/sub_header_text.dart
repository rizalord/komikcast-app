import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/env.dart';

// SUB HEADER
class SubHeader extends StatelessWidget {
  const SubHeader({
    Key key,
    this.text,
    this.width,
    this.withNext = true,
    this.action,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final double width;
  final bool withNext;
  final Widget action;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      // color: Colors.blue[50],
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: action != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text.toUpperCase(),
                  style: GoogleFonts.heebo(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Env.primaryColor,
                  ),
                ),
                withNext
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Env.primaryColor,
                        ),
                        onPressed: () {},
                      )
                    : Container(),
                action,
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text.toUpperCase(),
                  style: GoogleFonts.heebo(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Env.primaryColor,
                  ),
                ),
                withNext
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Env.primaryColor
                        ),
                        onPressed: onPressed,
                      )
                    : Container(),
              ],
            ),
    );
  }
}
