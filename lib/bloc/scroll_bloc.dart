import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollBloc extends Bloc<bool, ScrollPhysics> {
  @override
  ScrollPhysics get initialState => NeverScrollableScrollPhysics();

  @override
  Stream<ScrollPhysics> mapEventToState(bool event) async* {
    yield event
        ? AlwaysScrollableScrollPhysics()
        : NeverScrollableScrollPhysics();
  }
}
