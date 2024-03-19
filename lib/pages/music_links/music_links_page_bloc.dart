import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncrosong/api.dart';

enum WebPageState { loading, ready, initial, error }

class MusicLinksScreenEvent {}

class ShareLinkUrl extends MusicLinksScreenEvent {
  final String url;

  ShareLinkUrl(this.url);
}

class BackNavigationEvent extends MusicLinksScreenEvent {}

class MusicPlatformsPageState {
  final String? pageUrl;
  final WebPageState state;

  MusicPlatformsPageState(this.pageUrl, this.state);

  MusicPlatformsPageState.ready(this.pageUrl) : state = WebPageState.ready;

  MusicPlatformsPageState.loading()
      : pageUrl = null,
        state = WebPageState.loading;

  MusicPlatformsPageState.error()
      : pageUrl = null,
        state = WebPageState.ready;

  MusicPlatformsPageState.initialState()
      : pageUrl = null,
        state = WebPageState.initial;
}

class MusicPlatformsPageBloc extends Bloc<MusicLinksScreenEvent, MusicPlatformsPageState> {
  final Api api;

  MusicPlatformsPageBloc(this.api) : super(MusicPlatformsPageState.initialState()) {
    on<MusicLinksScreenEvent>((event, emit) async {
      if (event is ShareLinkUrl) {
        emit(MusicPlatformsPageState.loading());
        String? pageUrl;
        try {
          pageUrl = await api.requestPageUrlFor(event.url);
        } catch (exception) {
          emit(MusicPlatformsPageState.error());
        }
        if (pageUrl != null) {
          emit(MusicPlatformsPageState.ready(pageUrl));
        } else {
          emit(MusicPlatformsPageState.error());
        }
      } else if (event is BackNavigationEvent) {
        emit(MusicPlatformsPageState.initialState());
      }
    });
  }
}
