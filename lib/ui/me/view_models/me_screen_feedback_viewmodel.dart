import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

enum FeedbackCategory {
  bug('Bug Report'),
  suggestion('Feature Suggestion'),
  ui('UI/Display Issue'),
  account('Account Issue'),
  other('Others');

  final String label;
  const FeedbackCategory(this.label);
}

class MeFeedbackViewModel extends ChangeNotifier {
  double _score = 8.0;
  double get score => _score;

  String _title = '';
  String get title => _title;

  String _description = '';
  String get description => _description;

  FeedbackCategory _category = FeedbackCategory.bug;
  FeedbackCategory get category => _category;

  String _contact = '';
  String get contact => _contact;

  final List<XFile> _images = [];
  List<XFile> get images => List.unmodifiable(_images);

  late final Command0 submitCommand;
  final ImagePicker _picker = ImagePicker();

  MeFeedbackViewModel() {
    submitCommand = Command0(_submit);
  }

  set score(double value) {
    if (_score != value) {
      _score = value;
      notifyListeners();
    }
  }

  void updateCategory(FeedbackCategory? value) {
    if (value != null && _category != value) {
      _category = value;
      notifyListeners();
    }
  }

  void updateTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void updateDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void updateContact(String value) {
    _contact = value;
    notifyListeners();
  }

  Future<void> pickImages() async {
    if (_images.length >= 3) return;

    final List<XFile> pickedImages = await _picker.pickMultiImage(
      imageQuality: 80,
      maxWidth: 1024,
    );

    if (pickedImages.isNotEmpty) {
      final remainingSlots = 3 - _images.length;
      _images.addAll(pickedImages.take(remainingSlots));
      notifyListeners();
    }
  }

  void removeImage(int index) {
    _images.removeAt(index);
    notifyListeners();
  }

  Future<Result<void>> _submit() async {
    // Mock submit logic
    await Future.delayed(const Duration(seconds: 1));
    if (kDebugMode) {
      print(
        'Feedback Submitted: '
        'Category: ${category.label}, '
        'Score: $score, '
        'Title: $title, '
        'Description: $description, '
        'Contact: $contact, '
        'Images: ${images.length}',
      );
    }
    return const Result.ok(null);
  }
}
