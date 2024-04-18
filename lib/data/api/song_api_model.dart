class SongApiModel {
  final DateTime searchTime;
  final String searchUrl;
  final String displayUrl;
  String searchedSongId;
  String artist;
  String title;
  Map<String, String> musicPlatformUrls;

  SongApiModel._({
    required this.searchTime,
    required this.searchUrl,
    required this.searchedSongId,
    required this.displayUrl,
    required this.musicPlatformUrls,
    required this.artist,
    required this.title,
  });

  factory SongApiModel.fromJson(
    Map<String, dynamic> json,
    DateTime searchTime,
    String searchUrl,
  ) {
    Map<String, dynamic> linksByPlatform = json["linksByPlatform"];
    Map<String, String> musicPlatformUrls = {};
    linksByPlatform.forEach((musicPlatformName, musicPlatformData) {
      musicPlatformUrls[musicPlatformName] = linksByPlatform[musicPlatformName]["url"];
    });

    Map<String, dynamic> entitiesByUniqueId = json["entitiesByUniqueId"];
    Map<String, dynamic> musicPlatformSongData =
        entitiesByUniqueId.isNotEmpty ? entitiesByUniqueId[entitiesByUniqueId.keys.first] : {};
    String title = musicPlatformSongData.isNotEmpty ? musicPlatformSongData["title"] : "";
    String artist = musicPlatformSongData.isNotEmpty ? musicPlatformSongData["artistName"] : "";

    return SongApiModel._(
      searchTime: searchTime,
      searchUrl: searchUrl,
      searchedSongId: json["entityUniqueId"],
      displayUrl: json["pageUrl"],
      title: title,
      artist: artist,
      musicPlatformUrls: musicPlatformUrls,
    );
  }
}
