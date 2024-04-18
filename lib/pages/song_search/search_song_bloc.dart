import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncrosong/data/repos/songs/song_item.dart';
import 'package:syncrosong/data/repos/songs/songs_repository.dart';
import 'package:syncrosong/router/router.dart';

enum SearchQueryState { loading, resetToInitial, initial, error }

abstract class _SearchSongEvent {}

class SongSubmitEvent extends _SearchSongEvent {
  final String url;

  SongSubmitEvent(this.url);
}

class ReturnedFromResultScreenEvent extends _SearchSongEvent {}

class SearchSongState {
  final SearchQueryState state;
  final String? navigationDestinationRoute;

  SearchSongState._(this.state, [this.navigationDestinationRoute]);

  SearchSongState.resetToInitial(String url) : this._(SearchQueryState.resetToInitial, url);

  SearchSongState.loading() : this._(SearchQueryState.loading);

  SearchSongState.error() : this._(SearchQueryState.error);

  SearchSongState.initialState() : this._(SearchQueryState.initial);
}

class SearchSongBloc extends Bloc<_SearchSongEvent, SearchSongState> {
  final SongRepository _songRepository;

  SearchSongBloc(this._songRepository) : super(SearchSongState.initialState()) {
    on<SongSubmitEvent>((event, emit) async {
      emit(SearchSongState.loading());
      String? pageUrl;
      try {
        SongItem songItem = await _songRepository.search(event.url);
        pageUrl = songItem.displayUrl;
      } catch (exception) {
        emit(SearchSongState.error());
      }
      if (pageUrl != null) {
        Uri navigationPath = Uri(
          path: AppRoute.fullMusicLinks.route,
          queryParameters: {AppNavigationParameterKeys.url: pageUrl},
        );
        emit(SearchSongState.resetToInitial(navigationPath.toString()));
      } else {
        emit(SearchSongState.error());
      }
    });
    on<ReturnedFromResultScreenEvent>((event, emit) async {
      emit(SearchSongState.initialState());
    });
  }
}
