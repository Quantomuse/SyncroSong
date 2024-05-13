import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncrosong/data/repos/songs/song_item.dart';
import 'package:syncrosong/localization/localized_text.dart';
import 'package:syncrosong/localization/text_manager.dart';
import 'package:syncrosong/pages/history/history_screen_bloc.dart';
import 'package:syncrosong/utility/widgets/Separator.dart';

import '../../utility/widgets/appbar_provider.dart';

class HistoryScreen extends StatelessWidget with TextProvider {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBarProvider.get(getText(LocalizedText.historyScreenTitle), context),
      body: BlocBuilder<SongHistoryBloc, SongHistoryState>(builder: (context, state) {
        return ListView.separated(
          itemBuilder: (_, index) => _SongHistoryRowItemWidget(state.songs[index]),
          separatorBuilder: (_, __) => const Separator(),
          addAutomaticKeepAlives: false,
          cacheExtent: 50,
          itemCount: state.songs.length,
        );
        // return Center(child: Text("History"));
      }),
    );
  }
}

class _SongHistoryRowItemWidget extends StatelessWidget {
  final SongItem songItem;

  const _SongHistoryRowItemWidget(this.songItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop(songItem.displayUrl);
      },
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songItem.artist,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    songItem.title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                textAlign: TextAlign.end,
                songItem.searchTime.prettyString,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension _PrettyDatePrint on DateTime {
  String get prettyString => "$hour:$minute\n$day.$month.$year";
}
