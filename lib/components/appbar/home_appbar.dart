import 'package:flutter/material.dart';
import 'package:komikcast/env.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:komikcast/bloc/pro_bloc.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; 

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(Env.appName),
      actions: [
        // IconButton(
        //   icon: FaIcon(
        //     FontAwesomeIcons.crown,
        //     size: 20,
        //   ),
        //   onPressed: () {},
        // ),
        // BlocBuilder<ProBloc, bool>(
        //   builder: (ctx, isPro) => isPro == true
        //       ? Container(
        //           alignment: Alignment.center,
        //           padding: EdgeInsets.symmetric(horizontal: 10),
        //           child: Container(
        //             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        //             decoration: BoxDecoration(
        //               border: Border.all(color: Colors.yellow, width: 2),
        //               borderRadius: BorderRadius.circular(8),
        //             ),
        //             child: Text(
        //               'PRO',
        //               style: TextStyle(
        //                 color: Colors.yellow,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //           ),
        //         )
        //       : IconButton(
        //           icon: FaIcon(
        //             FontAwesomeIcons.crown,
        //             size: 20,
        //           ),
        //           onPressed: () => Modular.to.pushNamed('/pro'),
        //         ),
        // ),
      ],
    );
  }
}
