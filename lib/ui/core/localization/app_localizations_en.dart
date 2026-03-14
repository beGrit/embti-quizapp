// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'mbti';

  @override
  String get startWithPhone => 'Start using the Phone';

  @override
  String get startWithEmail => 'Start using the Email';

  @override
  String get startAsGuest => 'Start as the Guest';

  @override
  String get navHome => 'Home';

  @override
  String get navMe => 'Me';

  @override
  String get desktopUnderDev => 'Desktop Version is under development...';

  @override
  String get desktopHint =>
      'Please access via mobile device for the full experience.';

  @override
  String get or => 'or';
}
