import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';

class MeFeedbackViewModel extends ChangeNotifier {
  double _score = 5.0;
  double get score => _score;

  String _title = '';
  String get title => _title;

  String _description = '';
  String get description => _description;

  late final Command0 submitCommand;

  MeFeedbackViewModel() {
    submitCommand = Command0(_submit);
  }

  set score(double value) {
    if (_score != value) {
      _score = value;
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

  Future<Result<void>> _submit() async {
    // Mock submit logic
    await Future.delayed(const Duration(seconds: 1));
    if (kDebugMode) {
      print('Feedback Submitted: Score: $score, Title: $title, Description: $description');
    }
    return const Result.ok(null);
  }
}
