import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncrosong/api.dart';
import 'package:syncrosong/router/router.dart';

enum SearchQueryState { loading, resetToInitial, initial, error }

class SongSubmitEvent {
  final String url;

  SongSubmitEvent(this.url);
}

class SearchSongState {
  final SearchQueryState state;
  final String? navigationDestinationRoute;

  SearchSongState._(this.state, [this.navigationDestinationRoute]);

  SearchSongState.resetToInitial(String url) : this._(SearchQueryState.resetToInitial, url);

  SearchSongState.loading() : this._(SearchQueryState.loading);

  SearchSongState.error() : this._(SearchQueryState.error);

  SearchSongState.initialState() : this._(SearchQueryState.initial);
}

class SearchSongBloc extends Bloc<SongSubmitEvent, SearchSongState> {
  final Api _api;

  SearchSongBloc(this._api) : super(SearchSongState.initialState()) {
    on<SongSubmitEvent>((event, emit) async {
      emit(SearchSongState.loading());
      String? pageUrl;
      try {
        pageUrl = await _api.requestPageUrlFor(event.url);
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
  }
}
