import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:komikcast/bloc/pro_bloc.dart';

class ProData {
  var db = Hive.box('komikcast');

  void getSevenDaysTrial(BuildContext context) {
    bool isTrialUsed = db.get('trial', defaultValue: false);

    if (isTrialUsed == false) {
      db.put('pro_expired_date',
          DateTime.now().millisecondsSinceEpoch + 604800000);
      db.put('trial', true);
      Modular.get<ProBloc>().add(true);
      Fluttertoast.showToast(
        msg: "You're using trial now",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:
            Theme.of(context).textSelectionHandleColor.withOpacity(.7),
        textColor: Theme.of(context).textSelectionColor.withOpacity(.8),
        fontSize: 16.0,
      );
      Modular.to.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: "Trial is expired",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:
            Theme.of(context).textSelectionHandleColor.withOpacity(.7),
        textColor: Theme.of(context).textSelectionColor.withOpacity(.8),
        fontSize: 16.0,
      );
    }
  }
}
