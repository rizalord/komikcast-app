import 'package:flutter_bloc/flutter_bloc.dart';

class ProBloc extends Bloc<bool, bool> {
  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
