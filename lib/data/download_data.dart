import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/bloc/download_bloc.dart';
import 'package:komikcast/data/comic_data.dart';
import 'package:komikcast/models/detail_chapter.dart';
import 'package:komikcast/models/detail_comic.dart';
import 'package:komikcast/models/download_status.dart';
import 'package:komikcast/models/init_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DownloadData {
  void downloadChapter({
    BuildContext context,
    List<SingleChapterDetail> data,
  }) async {
    if (data.length == 0)
      Modular.to.pop(context);
    else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => BlocBuilder<DownloadBloc, DownloadStatus>(
          builder: (context, state) => WillPopScope(
            onWillPop: () async {
              return state.percent == 100;
            },
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Downloading...'),
                      Text('${state.currentIndex}/${state.total}'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * .64,
                      lineHeight: 10.0,
                      percent: state.percent / 100,
                      backgroundColor: Colors.grey.withOpacity(.5),
                      progressColor: Colors.lightBlue,
                      animation: false,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      );
      downloadFiles(data: data, context: context);
    }
  }

  void downloadFiles({
    List<SingleChapterDetail> data,
    BuildContext context,
    int index = 0,
  }) async {
    Dio dio = Dio();
    var appDir = await getExternalStorageDirectory();

    // get Total Images
    int totalImage = 0;
    int imageDownloaded = 0;
    for (var item in data) {
      DetailChapter detail =
          await ComicData.getChapterKomik(id: data[0].linkId);
      for (var image in detail.images) {
        totalImage++;
      }
    }

    try {
      for (var item in data) {
        DetailChapter detail =
            await ComicData.getChapterKomik(id: data[0].linkId);
        for (var image in detail.images) {
          var savePath = appDir.path.toString() +
              '/' +
              detail.comicLinkId +
              '/' +
              item.linkId +
              image.link.split('/').last;
          var downloadPath = image.link;

          await dio.download(downloadPath, savePath,
              onReceiveProgress: (rec, total) {
            var percent = ((rec / total) * 100);

            if (percent.toInt() == 100) {
              imageDownloaded += 1;
            }

            Modular.get<DownloadBloc>().add(
              DownloadStatus(
                currentIndex: data.indexOf(item) + 1,
                total: data.length,
                percent: ((imageDownloaded / totalImage) * 100).toInt(),
              ),
            );

            if (imageDownloaded == totalImage) {
              Future.delayed(Duration(milliseconds: 1500), () {
                Navigator.pop(context);
                Future.delayed(Duration(milliseconds: 1000), () {
                  Modular.get<DownloadBloc>().add(
                    DownloadStatus(currentIndex: 0, total: 0, percent: 0),
                  );
                });
              });

              KomikcastSystem().downloadsInit();
            }
          });
        }
      }
    } catch (e) {}
  }
}
