import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterReadedBloc extends Bloc<List<String>, List<String>> {
  @override
  List<String> get initialState => [];

  @override
  Stream<List<String>> mapEventToState(List<String> event) async* {
    yield event;
  }
}
