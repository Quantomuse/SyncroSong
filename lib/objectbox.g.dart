// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'data/database/songs/song_db_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(4, 4984973540066676757),
      name: 'SongItemDBModel',
      lastPropertyId: const obx_int.IdUid(8, 8343959674164060004),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 3625664405525879121),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 4737042195830755845),
            name: 'searchTime',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 122255054473164945),
            name: 'searchUrl',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 1433308180464324609),
            name: 'displayUrl',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 6861391577398648945),
            name: 'title',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 4218717228667939126),
            name: 'artist',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 2940229906517322011),
            name: 'musicPlatformUrlsJson',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(4, 4984973540066676757),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [
        4508225432622317640,
        1493004821366748285,
        8928330452407152392
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        881479112126892328,
        8805207047466182260,
        4745228686876180532,
        7757961741493142523,
        5552733225234886090,
        1486731192973932040,
        5083457390796461825,
        8552008175875141140,
        411465260512973303,
        335043929613188638,
        3907720544543287299,
        1866843716216474729,
        5012057143008498097,
        3095337713310816454,
        6217092385194189766,
        4762068841302943031,
        7493380137911443433,
        3944622113646184595,
        5709097904966765377,
        8343959674164060004
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    SongItemDBModel: obx_int.EntityDefinition<SongItemDBModel>(
        model: _entities[0],
        toOneRelations: (SongItemDBModel object) => [],
        toManyRelations: (SongItemDBModel object) => {},
        getId: (SongItemDBModel object) => object.id,
        setId: (SongItemDBModel object, int id) {
          object.id = id;
        },
        objectToFB: (SongItemDBModel object, fb.Builder fbb) {
          final searchUrlOffset = object.searchUrl == null
              ? null
              : fbb.writeString(object.searchUrl!);
          final displayUrlOffset = object.displayUrl == null
              ? null
              : fbb.writeString(object.displayUrl!);
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final artistOffset =
              object.artist == null ? null : fbb.writeString(object.artist!);
          final musicPlatformUrlsJsonOffset =
              object.musicPlatformUrlsJson == null
                  ? null
                  : fbb.writeString(object.musicPlatformUrlsJson!);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.searchTime?.millisecondsSinceEpoch);
          fbb.addOffset(2, searchUrlOffset);
          fbb.addOffset(3, displayUrlOffset);
          fbb.addOffset(4, titleOffset);
          fbb.addOffset(5, artistOffset);
          fbb.addOffset(6, musicPlatformUrlsJsonOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final searchTimeValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 6);
          final searchTimeParam = searchTimeValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(searchTimeValue);
          final searchUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final displayUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 12);
          final artistParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 14);
          final musicPlatformUrlsJsonParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16);
          final object = SongItemDBModel(
              searchTimeParam,
              searchUrlParam,
              displayUrlParam,
              titleParam,
              artistParam,
              musicPlatformUrlsJsonParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [SongItemDBModel] entity fields to define ObjectBox queries.
class SongItemDBModel_ {
  /// see [SongItemDBModel.id]
  static final id =
      obx.QueryIntegerProperty<SongItemDBModel>(_entities[0].properties[0]);

  /// see [SongItemDBModel.searchTime]
  static final searchTime =
      obx.QueryDateProperty<SongItemDBModel>(_entities[0].properties[1]);

  /// see [SongItemDBModel.searchUrl]
  static final searchUrl =
      obx.QueryStringProperty<SongItemDBModel>(_entities[0].properties[2]);

  /// see [SongItemDBModel.displayUrl]
  static final displayUrl =
      obx.QueryStringProperty<SongItemDBModel>(_entities[0].properties[3]);

  /// see [SongItemDBModel.title]
  static final title =
      obx.QueryStringProperty<SongItemDBModel>(_entities[0].properties[4]);

  /// see [SongItemDBModel.artist]
  static final artist =
      obx.QueryStringProperty<SongItemDBModel>(_entities[0].properties[5]);

  /// see [SongItemDBModel.musicPlatformUrlsJson]
  static final musicPlatformUrlsJson =
      obx.QueryStringProperty<SongItemDBModel>(_entities[0].properties[6]);
}
