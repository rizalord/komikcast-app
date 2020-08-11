import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteSortBloc extends Bloc<String, String> {
  @override
  String get initialState => 'asc';

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}
