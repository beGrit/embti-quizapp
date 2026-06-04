import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class PocketBaseDateTimeConverter implements JsonConverter<DateTime, String> {
  const PocketBaseDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    // PocketBase sends dates like "2026-05-17 01:26:39.123Z"
    // Replacing the space with 'T' guarantees Dart's DateTime.parse won't crash
    final normalized = json.contains(' ') && !json.contains('T')
        ? json.replaceFirst(' ', 'T')
        : json;
    return DateTime.parse(
      normalized,
    ).toLocal(); // Convert to local timezone for the UI
  }

  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}

class FirestoreTimestampConverter implements JsonConverter<DateTime, dynamic> {
  const FirestoreTimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    }
    if (json is String) {
      return DateTime.parse(json);
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime object) => Timestamp.fromDate(object);
}
