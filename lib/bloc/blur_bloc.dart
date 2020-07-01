import 'package:flutter_bloc/flutter_bloc.dart';

class BlurBloc extends Bloc<double, double> {
  @override
  double get initialState => 0.0;

  @override
  Stream<double> mapEventToState(double event) async* {
    yield event;
  }
}
