import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncrosong/data/repos/songs/songs_repository.dart';
import 'package:syncrosong/utility/logger.dart';

import '../../data/repos/songs/song_item.dart';

enum ScreenState { loading, empty, data }

class SongHistoryState {
  final List<SongItem> songs;
  final ScreenState screenState;

  SongHistoryState.initial()
      : songs = [],
        screenState = ScreenState.loading;

  SongHistoryState.data(this.songs) : screenState = songs.isEmpty ? ScreenState.empty : ScreenState.data;
}

class SongHistoryBloc extends Cubit<SongHistoryState> {
  final SongRepository _songRepository;

  SongHistoryBloc(this._songRepository) : super(SongHistoryState.initial()) {
    initialize();
  }

  Future<void> initialize() async {
    final List<SongItem> songs = await _songRepository.getHistory();
    logger.info("Song search history: $songs");
    emit(SongHistoryState.data(songs));
  }
}
