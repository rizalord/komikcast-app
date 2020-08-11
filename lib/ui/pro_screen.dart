import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/data/pro_data.dart';

class ProScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: width,
                height: width * .58,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/pro-bg.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 0,
                      child: IconButton(
                        onPressed: () => Modular.to.pop(context),
                        icon: Icon(Icons.close),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check,
                            size: 25,
                            color: Colors.lightBlue[300],
                          ),
                          SizedBox(width: 9),
                          Text(
                            'Tanpa Iklan',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check,
                            size: 25,
                            color: Colors.lightBlue[300],
                          ),
                          SizedBox(width: 9),
                          Text(
                            'Unlimited Favorite',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check,
                            size: 25,
                            color: Colors.lightBlue[300],
                          ),
                          SizedBox(width: 9),
                          Text(
                            'Unlimited Download',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check,
                            size: 25,
                            color: Colors.lightBlue[300],
                          ),
                          SizedBox(width: 9),
                          Text(
                            'Dark Mode Support',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              // Container(
              //   height: 50,
              //   width: width * .9,
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //           padding: EdgeInsets.symmetric(horizontal: 10),
              //           child: TextField(
              //             keyboardType: TextInputType.number,
              //             decoration: InputDecoration(
              //               // labelText: 'Masukkan kode',
              //               hintText: 'Masukkan kode',
              //             ),
              //           ),
              //         ),
              //       ),
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(width),
              //         child: Material(
              //           child: Ink(
              //             decoration: BoxDecoration(
              //               color: Colors.lightBlue,
              //               borderRadius: BorderRadius.circular(width),
              //             ),
              //             child: InkWell(
              //               onTap: () {},
              //               child: Container(
              //                 padding: EdgeInsets.symmetric(
              //                   horizontal: 12,
              //                   vertical: 8,
              //                 ),
              //                 child: Text(
              //                   'Activate',
              //                   style: TextStyle(color: Colors.white),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 30),
              ButtonBuy(width: width),
              SizedBox(height: 15),
              ButtonCustom(width: width),
              SizedBox(height: 7.5),
              Text(
                '15-hari uji coba gratis.',
                style: GoogleFonts.heebo(
                  fontSize: 12,
                  color: Theme.of(context)
                      .textSelectionHandleColor
                      .withOpacity(.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(width),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[400],
                Colors.blue,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(width),
          ),
          child: InkWell(
            onTap: () => ProData().getSevenDaysTrial(context),
            child: Container(
              width: width * .9,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'COBA PRO GRATIS',
                style: GoogleFonts.heebo(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonBuy extends StatelessWidget {
  const ButtonBuy({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(width),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange[300],
                Colors.orange[700],
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(width),
          ),
          child: InkWell(
            onTap: () {},
            child: Container(
              width: width * .9,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1 PERANGKAT',
                    style: GoogleFonts.heebo(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          'Rp',
                          style: GoogleFonts.heebo(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '15.000',
                          style: GoogleFonts.heebo(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 1),
                        Text(
                          '/perangkat',
                          style: GoogleFonts.heebo(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
