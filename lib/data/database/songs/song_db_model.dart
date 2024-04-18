import 'package:objectbox/objectbox.dart';

@Entity()
class SongItemDBModel {
  @Id()
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime? searchTime;

  String? searchUrl;

  String? displayUrl;

  String? title;

  String? artist;

  String? musicPlatformUrlsJson;

  SongItemDBModel(
    this.searchTime,
    this.searchUrl,
    this.displayUrl,
    this.title,
    this.artist,
    this.musicPlatformUrlsJson,
  );

  bool hasNoMissingValues() =>
      searchTime != null &&
      searchUrl != null &&
      title != null &&
      displayUrl != null &&
      artist != null &&
      musicPlatformUrlsJson != null;
}
