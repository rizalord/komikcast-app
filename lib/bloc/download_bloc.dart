import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komikcast/models/download_status.dart';

class DownloadBloc extends Bloc<DownloadStatus, DownloadStatus> {
  @override
  DownloadStatus get initialState => DownloadStatus(
        currentIndex: 0,
        total: 0,
        percent: 0,
      );

  @override
  Stream<DownloadStatus> mapEventToState(DownloadStatus event) async* {
    yield event;
  }
}
