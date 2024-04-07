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
      // {
      //   "amazonMusic": MusicPlatformApiModel.fromJson(linksByPlatform["amazonMusic"]),
      //   "amazonStore": MusicPlatformApiModel.fromJson(linksByPlatform["amazonStore"]),
      //   "audiomack": MusicPlatformApiModel.fromJson(linksByPlatform["audiomack"]),
      //   "anghami": MusicPlatformApiModel.fromJson(linksByPlatform["anghami"]),
      //   "boomplay": MusicPlatformApiModel.fromJson(linksByPlatform["boomplay"]),
      //   "deezer": MusicPlatformApiModel.fromJson(linksByPlatform["deezer"]),
      //   "appleMusic": MusicPlatformApiModel.fromJson(linksByPlatform["appleMusic"]),
      //   "itunes": MusicPlatformApiModel.fromJson(linksByPlatform["itunes"]),
      //   "napster": MusicPlatformApiModel.fromJson(linksByPlatform["napster"]),
      //   "pandora": MusicPlatformApiModel.fromJson(linksByPlatform["pandora"]),
      //   "soundcloud": MusicPlatformApiModel.fromJson(linksByPlatform["soundcloud"]),
      //   "tidal": MusicPlatformApiModel.fromJson(linksByPlatform["tidal"]),
      //   "yandex": MusicPlatformApiModel.fromJson(linksByPlatform["yandex"]),
      //   "youtube": MusicPlatformApiModel.fromJson(linksByPlatform["youtube"]),
      //   "youtubeMusic": MusicPlatformApiModel.fromJson(linksByPlatform["youtubeMusic"]),
      //   "spotify": MusicPlatformApiModel.fromJson(linksByPlatform["spotify"]),
      // },
    );
  }
}
//
// class LinksByPlatform {
//
//   LinksByPlatform({required this.musicPlatforms});
//
//   factory LinksByPlatform.fromJson(Map<String, dynamic> json) => LinksByPlatform(musicPlatforms: {
//     "amazonMusic": MusicPlatformApiModel.fromJson(json["amazonMusic"]),
//     "amazonStore": MusicPlatformApiModel.fromJson(json["amazonStore"]),
//     "audiomack": MusicPlatformApiModel.fromJson(json["audiomack"]),
//     "anghami": MusicPlatformApiModel.fromJson(json["anghami"]),
//     "boomplay": MusicPlatformApiModel.fromJson(json["boomplay"]),
//     "deezer": MusicPlatformApiModel.fromJson(json["deezer"]),
//     "appleMusic": MusicPlatformApiModel.fromJson(json["appleMusic"]),
//     "itunes": MusicPlatformApiModel.fromJson(json["itunes"]),
//     "napster": MusicPlatformApiModel.fromJson(json["napster"]),
//     "pandora": MusicPlatformApiModel.fromJson(json["pandora"]),
//     "soundcloud": MusicPlatformApiModel.fromJson(json["soundcloud"]),
//     "tidal": MusicPlatformApiModel.fromJson(json["tidal"]),
//     "yandex": MusicPlatformApiModel.fromJson(json["yandex"]),
//     "youtube": MusicPlatformApiModel.fromJson(json["youtube"]),
//     "youtubeMusic": MusicPlatformApiModel.fromJson(json["youtubeMusic"]),
//     "spotify": MusicPlatformApiModel.fromJson(json["spotify"]),
//   });
// }

// class MusicPlatformApiModel {
//   String url;
//   String entityUniqueId;
//
//   MusicPlatformApiModel({
//     required this.url,
//     required this.entityUniqueId,
//   });
//
//   factory MusicPlatformApiModel.fromJson(Map<String, dynamic> json) => MusicPlatformApiModel(
//         url: json["url"],
//         entityUniqueId: json["entityUniqueId"],
//       );
// }

// import 'package:json_annotation/json_annotation.dart';
//
// part 'song_api_model.g.dart';
//
//
// @JsonSerializable(explicitToJson: true)
// class SongApiResponseModel {
//   @JsonKey(name: "pageUrl")
//   final String displayUrl;
//
//   @JsonKey(name: "entityUniqueId")
//   final String id;
//
//   // @JsonKey(name: "linksByPlatform")
//   // final Map<String, SongApiResponseModel> platformUrls;
//   @JsonKey(name: "linksByPlatform")
//   final List<SongApiResponseModel> platformUrls;
//
//   SongApiResponseModel({required this.displayUrl, required this.id, required this.platformUrls});
//
//   factory SongApiResponseModel.fromJson(Map<String, dynamic> json) => _$SongApiResponseModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SongApiResponseModelToJson(this);
// }
//
// @JsonSerializable()
// class SongPlatformApiModel {
//   @JsonKey(name: "entityUniqueId")
//   final String id;
//
//   @JsonKey(name: "url")
//   final String url;
//
//   SongPlatformApiModel({required this.url, required this.id});
//
//   factory SongPlatformApiModel.fromJson(Map<String, dynamic> json) => _$SongPlatformApiModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SongPlatformApiModelToJson(this);
// }
//
// @JsonSerializable()
// class SongPlatformApiModelData {
//   @JsonKey(name: "entityUniqueId")
//   final String id;
//
//   @JsonKey(name: "url")
//   final String url;
//
//   SongPlatformApiModelData({required this.url, required this.id});
//
//   factory SongPlatformApiModelData.fromJson(Map<String, dynamic> json) => _$SongPlatformApiModelDataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SongPlatformApiModelDataToJson(this);
// }
//
// // @JsonSerializable()
// // class SongSearchApiResponse {
// //   final String displayUrl
// //   final List<>
// //
// //   SongSearchApiResponse({required this.title, required this.artistName});
// // }
// //
// // @JsonSerializable()
// // class SongPlatformApiData {
// //   final String platformName;
// //   final String url;
// //
// //   SongPlatformApiData({required this.platformName, required this.url});
// // }
