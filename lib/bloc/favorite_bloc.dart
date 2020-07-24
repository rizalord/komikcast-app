import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<List<Map>, List<Map>> {
  @override
  List<Map> get initialState => [];

  @override
  Stream<List<Map>> mapEventToState(List<Map> event) async* {
    yield event;
  }
}
