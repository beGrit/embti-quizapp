part of 'content.dart';

extension VideoContentX on VideoContent {
  bool get hasMatch => matchScore != null;
  
  String get matchDisplay => hasMatch 
      ? "You <-> Sherlock ($authorMbti): $matchScore% Match!" 
      : "";
}