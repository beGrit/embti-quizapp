part of 'content.dart';

extension KnowledgeContentX on KnowledgeContent {
  bool get isBook => category.toLowerCase() == 'book';
}
