import 'package:objectbox/objectbox.dart';

@Entity()
class SongDBModel {
  @Id()
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime? searchTime;

  String? searchUrl;

  String? displayUrl;

  String? name;

  SongDBModel(this.searchTime, this.searchUrl, this.displayUrl, this.name);

  bool hasNoMissingValues() => searchTime != null && searchUrl != null && name != null && displayUrl != null;
}
