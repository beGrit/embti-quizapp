import 'package:freezed_annotation/freezed_annotation.dart';

part 'common.freezed.dart';
part 'common.g.dart';

/// Value Object representing a file resource (e.g., an image or attachment)
@freezed
abstract class AppFile with _$AppFile {
  const factory AppFile({required Uri uri, required String name}) = _AppFile;

  factory AppFile.fromJson(Map<String, dynamic> json) =>
      _$AppFileFromJson(json);
}
