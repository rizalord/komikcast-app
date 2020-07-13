import 'package:flutter_bloc/flutter_bloc.dart';

class ReverseChapterBloc extends Bloc<bool, bool> {
  bool initState = false;

  @override
  bool get initialState => initState;

  @override
  Stream<bool> mapEventToState(event) async* {
    yield event;
  }
}
