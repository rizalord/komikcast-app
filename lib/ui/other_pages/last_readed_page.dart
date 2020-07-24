import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/bloc/history_bloc.dart';

class LastReadedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Last Readed'),
      ),
      body: BlocBuilder<HistoryBloc, List<Map>>(
        builder: (context, state) {
          state = state.reversed.toList();
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () => Modular.to.pushNamed('readmanga' , arguments: {
                'mangaId': state[index]['mangaId'],
                'currentId': state[index]['chapterId'],
              }),
              title: Text(
                state[index]['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('Chapter ' + state[index]['chapterName']),
              leading: CachedNetworkImage(
                imageUrl: state[index]['image'],
              ),
            ),
          );
        },
      ),
    );
  }
}
